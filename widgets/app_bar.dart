import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/home/drawer_actions/settings/setting_page.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  AppBarWidget({
    Key? key,
    this.showNotificationDot = true,
    this.isCenterTitle = true,
    this.hasDrawer = false,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  final bool showNotificationDot;
  final bool isCenterTitle;
  final bool hasDrawer;

  @override
  Widget build(BuildContext context) {
    print('RRRRRRRRR');
    print(hasDrawer);
    print('---------');
    return AppBar(
      // backgroundColor: Colors.white.withOpacity(0.1),
      leadingWidth: 50,

      centerTitle: isCenterTitle,
      leading: hasDrawer
          ? Padding(
              padding: const EdgeInsets.only(left: 25),
              child: GestureDetector(
                onTap: () {
                  if (parentScaffoldKey != null) {
                    parentScaffoldKey?.currentState?.openDrawer();
                  }
                },
                child: Image.asset(
                  AppAssets.drawerIcon,
                  width: 21,
                  height: 14,
                ),
              ),
            )
          : null,
      // IconButton(icon: Icon(Icons.arrow_back),),
      actions: [
        Stack(
          children: [
            Center(child: Image.asset(AppAssets.bellIcon)),
            if (showNotificationDot)
              Positioned(
                right: 2,
                top: -15,
                bottom: 0,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1D681),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        GestureDetector(
          onTap: () {
            AppNavigation.to(context, const SettingPage());
          },
          child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: CircleAvatar(
                radius: 15,
                child: Image.asset(AppAssets.user),
              )),
        ),
      ],
    );
  }

  final _appBar = AppBar();

  @override
  Widget get child => _appBar;

  @override
  Size get preferredSize => _appBar.preferredSize;
}

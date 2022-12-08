import 'dart:ui';

import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/home/home_page.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYouWidget extends StatelessWidget {
  const ThankYouWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF728FD6), Color(0xFFE0DF9F)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          // image: DecorationImage(
          //   image: AssetImage(AppAssets.starsIcon),
          //   fit: BoxFit.contain
          // ),
          color: Color(0xFF0B002A),
        ),
        margin: const EdgeInsets.all(3),
        padding: EdgeInsets.fromLTRB(
          30,
          0,
          30,
          10 + MediaQuery.of(context).padding.bottom,
        ),
        child: Stack(children: [
          Image.asset(AppAssets.starsIcon),
          Column(mainAxisSize: MainAxisSize.min, children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Transform.translate(
                offset: const Offset(0, -40),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0B002A),
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF728FD6),
                        Color(0xFFE0DF9F),
                      ],
                    ),
                  ),
                  child: Container(
                    height: 79,
                    width: 79,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0B002A),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.fromLTRB(30, 24, 31, 37),
                    child: Image.asset(
                      AppAssets.crossIcon,
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Image.asset(
              AppAssets.thumbIcon,
            ),
            const SizedBox(height: 38),
            Text(
              'Thank You!',
              style: GoogleFonts.oswald(
                fontSize: 33,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 9, 0, 50),
              child: Text(
                'You are consciously evolving every day',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  letterSpacing: 2,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppButtonWidget(
                title: 'Back To HomePage',
                onPressed: () async {
                  AppNavigation.navigateRemoveUntil(context, const HomePage());
                },
              ),
            )
          ]),
        ]),
      ),
    );
  }
}

dynamic $showBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: child,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
  );
}

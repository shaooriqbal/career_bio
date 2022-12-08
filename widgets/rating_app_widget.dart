import 'dart:ui';

import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingStarWidget extends StatefulWidget {
  const RatingStarWidget({Key? key}) : super(key: key);

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0B002A),
          gradient:
              LinearGradient(colors: [Color(0xFF728FD6), Color(0xFFE0DF9F)]),
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
            image: DecorationImage(image: AssetImage(AppAssets.starsIcon)),
            color: Color(0xFF0B002A),
          ),
          margin: const EdgeInsets.all(2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Transform.translate(
                  offset: const Offset(0, -35),
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
                      height: 54,
                      width: 55,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0B002A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 40),
                child: Text(
                  'Enjoying the app?',
                  style: GoogleFonts.oswald(fontSize: 33, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  'We can’t wait to hear from you',
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w100),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...[
                    for (var i = 0; i < 5; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 5),
                        child: Image.asset(AppAssets.ratingStar,
                            width: 36, height: 36),
                      ),
                  ]
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 10, 60, 60),
                child: AppButtonWidget(
                  title: 'Rate Us Now',
                  onPressed: () async {
                    AppNavigation.pop(context);
                  },
                ),
              )
            ],
          ),
        ));
  }
}

dynamic $showRatingBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: child),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
  );
}

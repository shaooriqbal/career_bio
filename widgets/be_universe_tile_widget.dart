import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniverseTileWidget extends StatelessWidget {
  const UniverseTileWidget(
      {Key? key,
      required this.text,
      required this.path,
      required this.onPressed})
      : super(key: key);
  final String text;
  final String path;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(
          left: 40,
          top: 17,
          bottom: 19,
          right: 17,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            stops: [0.1, 1],
            end: Alignment.centerRight,
            begin: Alignment.centerLeft,
            colors: [
              Color(0xFF3A2E51),
              Color(0xff56528E),
              // Color(0xff56528E),
            ],
          ),
        ),
        margin: const EdgeInsets.only(bottom: 17),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(path, width: 40, height: 40),
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                    stops: [0.2, 1],
                    end: Alignment.centerRight,
                    begin: Alignment.centerLeft,
                    colors: [
                      Color(0xffD2876F),
                      Color(0xFF4F2A98),
                    ]),
              ),
              child: const Icon(
                Icons.keyboard_double_arrow_right,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

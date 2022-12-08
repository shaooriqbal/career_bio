import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RedText extends StatelessWidget {
  final String text;

  const RedText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 15,
        color: const Color(0xFFD3896F),
        letterSpacing: 1,
      ),
    );
  }
}
class GoalsPageTitle extends StatelessWidget {
  final String text;

  const GoalsPageTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.oswald(
        fontSize: 33,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class GoalsPageDescription extends StatelessWidget {
  final String text;

  const GoalsPageDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.w300),
    );
  }
}

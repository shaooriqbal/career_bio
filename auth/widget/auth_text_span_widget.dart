import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextSpanWidget extends StatelessWidget {
  const AuthTextSpanWidget({
    Key? key,
    required this.message,
    required this.buttonTitle,
    required this.action,
  }) : super(key: key);

  final String message;
  final String buttonTitle;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: message,
        style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.6)),
        children: [
          TextSpan(
            text: buttonTitle,
            style: const TextStyle(color: Color(0xFFD3896F)),
            recognizer: TapGestureRecognizer()..onTap = action,
          ),
        ],
      ),
    );
  }
}

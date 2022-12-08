import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        textTheme: GoogleFonts.oswaldTextTheme(),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          color: Colors.transparent,
        ),
      );
}

class AppColors {
  static const primaryColor = Color(0xFF17682E);
  static const buttonGradient = [Color(0xFFF0D781), Color(0xFFDA8B6D)];
  static const inverseButtonGradient = [Color(0xFFDA8B6D), Color(0xFFF0D781)];
}

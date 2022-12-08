import 'package:flutter/material.dart';

class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget({
    Key? key,
    required this.title,
    this.align,
    this.fontWeight,
  }) : super(key: key);

  final String title;
  final Alignment? align;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align ?? Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/base/theme.dart';
import 'package:be_universe/src/utils/app_utils.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButtonWidget extends StatefulWidget {
  const AppButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.isIcon = true,
    this.after,
    this.before,
  }) : super(key: key);

  final Future<void> Function()? onPressed;
  final VoidCallback? before;
  final VoidCallback? after;
  final String title;
  final bool? isIcon;

  @override
  State<AppButtonWidget> createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (_isLoading) {
      child = Center(
        child: CircularProgressIndicator(
          color: Colors.deepOrangeAccent.withOpacity(0.5),
          strokeWidth: 3,
        ),
      );
    } else {
      child = Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Text(
              widget.title.toUpperCase(),
              style: GoogleFonts.oswald(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          widget.isIcon == true
              ? Positioned(
                  right: 16,
                  bottom: -3.3,
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFDA8B6D),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.0),
                        ],
                      ),
                    ),
                    child: const Icon(Icons.arrow_forward_sharp),
                  ),
                )
              : const SizedBox(),
        ],
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: AppColors.buttonGradient,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          disabledForegroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          minimumSize: const Size.fromHeight(66),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: _isLoading || widget.onPressed == null
            ? null
            : () async {
                AppUtils.unFocus();
                _isLoading = true;
                setState(() {});
                try {
                  if (widget.before != null) {
                    widget.before!();
                  }
                  await widget.onPressed!();
                } catch (e) {
                  if (!mounted) return;
                  ErrorDialog(error: DioException.withDioError(e))
                      .show(context);
                }
                if (!mounted) return;
                if (widget.after != null) {
                  widget.after!();
                }
                _isLoading = false;
                setState(() {});
              },
        child: child,
      ),
    );
  }
}

class AppCourseButtonWidget extends StatelessWidget {
  const AppCourseButtonWidget({
    Key? key,
    this.title,
    required this.onTap,
    this.isShadowed = false,
    this.bottomPadding,
  }) : super(key: key);

  final double? bottomPadding;
  final bool isShadowed;
  final String? title;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: bottomPadding ?? 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(120),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF728FD6),
            Color(0xFFD8D9A3),
          ],
        ),
        boxShadow: isShadowed
            ? [
                BoxShadow(
                  color: const Color(0xFFD8D9A3).withOpacity(0.25),
                  offset: const Offset(6, 2),
                  spreadRadius: 5,
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(120),
          ),
          padding: const EdgeInsets.symmetric(vertical: 17),
          disabledForegroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        onPressed: onTap,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            title ?? "Go to Coursework",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: const Color(0xFF140D36),
            ),
          ),
          const SizedBox(width: 18),
          const Icon(
            Icons.keyboard_double_arrow_right,
            color: Color(0xFF140D36),
          )
        ]),
      ),
    );
  }
}

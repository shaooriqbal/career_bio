import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/services/auth_api.dart';
import 'package:be_universe/src/utils/app_utils.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum _AuthType { google, facebook, apple }

class SocialAuthButton extends StatefulWidget {
  const SocialAuthButton.google({
    Key? key,
    this.after,
    this.before,
  })  : _type = _AuthType.google,
        super(key: key);

  const SocialAuthButton.facebook({
    Key? key,
    this.after,
    this.before,
  })  : _type = _AuthType.facebook,
        super(key: key);

  const SocialAuthButton.apple({
    Key? key,
    this.after,
    this.before,
  })  : _type = _AuthType.apple,
        super(key: key);

  final VoidCallback? before;
  final VoidCallback? after;
  final _AuthType _type;

  @override
  State<SocialAuthButton> createState() => _SocialAuthButtonState();
}

class _SocialAuthButtonState extends State<SocialAuthButton> {
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
      late String image;
      late String name;
      switch (widget._type) {
        case _AuthType.google:
          name = 'Google';
          image = AppAssets.google;
          break;
        case _AuthType.facebook:
          name = 'Facebook';
          image = AppAssets.facebook;
          break;
        case _AuthType.apple:
          name = 'Apple';
          image = AppAssets.apple;
          break;
      }
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 36, height: 36),
          const SizedBox(width: 22),
          Text(
            'Login with $name',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ],
      );
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        boxShadow: const [
          BoxShadow(
            offset: Offset(15, 0),
            blurRadius: 30,
            spreadRadius: 0,
            color: Color.fromRGBO(211, 212, 226, 0.25),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // backgroundColor: const Color.fromRGBO(255, 255, 255, 0.05),
          // backgroundColor: Colors.white.withOpacity(0.5),
          backgroundColor: Colors.transparent,
          minimumSize: const Size.fromHeight(66),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _isLoading
            ? null
            : () async {
                AppUtils.unFocus();
                _isLoading = true;
                setState(() {});
                try {
                  if (widget.before != null) {
                    widget.before!();
                  }
                  final service = AuthenticationService();
                  switch (widget._type) {
                    case _AuthType.google:
                      await service.signInWithGoogle(this);
                      break;
                    case _AuthType.facebook:
                      await service.signInWithFacebook(this);
                      break;
                    case _AuthType.apple:
                      await service.signInWithApple(this);
                      break;
                  }
                } catch (e) {
                  if (!mounted) return;
                  ErrorDialog(
                    error: DioException.withDioError(e),
                  ).show(context);
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

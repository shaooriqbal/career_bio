import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_universe/src/components/auth/widget/new_password_page.dart';
import 'package:be_universe/src/components/auth/widget/otp_sign_out_button.dart';
import 'package:be_universe/src/components/auth/widget/timed_widget.dart';
import 'package:be_universe/src/components/home/home_view.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    Key? key,
    this.forgotEmail,
    this.isTimer = true,
  }) : super(key: key);

  final String? forgotEmail;
  final bool isTimer;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool get isForgotPassword => widget.forgotEmail != null;

  String? _codeEntered;
  bool canVerify = false;

  final _digit1 = FocusNode();
  final _digit2 = FocusNode();
  final _digit3 = FocusNode();
  final _digit4 = FocusNode();

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();

  bool _isCodeValid(List<String> digits) {
    return digits.fold(true, (v, e) => v && e.isNotEmpty && e != ' ');
  }

  ValueChanged<String?> _digitInputHandler(
    FocusNode? prev,
    FocusNode current,
    FocusNode? next,
  ) {
    return (String? val) {
      if (val != null && val.isNotEmpty) {
        if (_isCodeValid([
          _controller1.text,
          _controller2.text,
          _controller3.text,
          _controller4.text,
        ])) {
          canVerify = true;
        }

        if (next == null) {
          _codeEntered = _controller1.text +
              _controller2.text +
              _controller3.text +
              _controller4.text;
          current.unfocus();
        } else {
          next.requestFocus();
        }
      } else {
        canVerify = false;
        prev?.requestFocus();
      }
      setState(() {});
    };
  }

  final boxShadow = [
    BoxShadow(
      offset: const Offset(18.59, 18.59),
      blurRadius: 37.17,
      color: const Color(0xFFD3D1D8).withOpacity(0.25),
    ),
  ];
  var _absorb = false;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return WillPopScope(
      onWillPop: () async => false,
      child: AbsorbPointer(
        absorbing: _absorb,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          extendBodyBehindAppBar: true,
          // appBar: AppBar(),
          body: BackgroundImageWidget(
            child: Padding(
              padding: EdgeInsets.only(
                top: padding.top + 56,
                bottom: padding.bottom,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(30, 22, 30, 0),
                child: Column(
                  children: [
                    const AuthTitleWidget(title: 'Verification'),
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'We’ve sent you a verification code to your email',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 62,
                          child: AppTextField(
                            boxShadow: boxShadow,
                            keyboardType: TextInputType.number,
                            onChanged: _digitInputHandler(
                              null,
                              _digit1,
                              _digit2,
                            ),
                            focusNode: _digit1,
                            textEditingController: _controller1,
                            textAlign: TextAlign.center,
                            hintColor: Colors.white,
                            maxLength: 1,
                            hint: '-',
                            bottomPadding: 45,
                            removeHint: true,
                          ),
                        ),
                        SizedBox(
                          width: 62,
                          child: AppTextField(
                            boxShadow: boxShadow,
                            keyboardType: TextInputType.number,
                            onChanged: _digitInputHandler(
                              _digit1,
                              _digit2,
                              _digit3,
                            ),
                            hint: '-',
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            hintColor: Colors.white,
                            focusNode: _digit2,
                            textEditingController: _controller2,
                            bottomPadding: 45,
                            removeHint: true,
                          ),
                        ),
                        SizedBox(
                          width: 62,
                          child: AppTextField(
                            boxShadow: boxShadow,
                            focusNode: _digit3,
                            keyboardType: TextInputType.number,
                            onChanged: _digitInputHandler(
                              _digit2,
                              _digit3,
                              _digit4,
                            ),
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            hint: '-',
                            hintColor: Colors.white,
                            textEditingController: _controller3,
                            bottomPadding: 45,
                            removeHint: true,
                          ),
                        ),
                        SizedBox(
                          width: 62,
                          child: AppTextField(
                            bottomPadding: 45,
                            boxShadow: boxShadow,
                            keyboardType: TextInputType.number,
                            onChanged: _digitInputHandler(
                              _digit3,
                              _digit4,
                              null,
                            ),
                            hintColor: Colors.white,
                            maxLength: 1,
                            hint: '-',
                            textAlign: TextAlign.center,
                            textEditingController: _controller4,
                            focusNode: _digit4,
                            removeHint: true,
                          ),
                        ),
                      ],
                    ),
                    AppButtonWidget(
                      before: () => setState(() => _absorb = true),
                      after: () => setState(() => _absorb = false),
                      onPressed: !canVerify ? null : _verify,
                      title: 'CONTINUE',
                    ),
                    const SizedBox(height: 28),
                    TimerWidget(
                      seconds: 60,
                      isTimer: widget.isTimer,
                      email: widget.forgotEmail,
                    ),
                    const SizedBox(height: 20),
                    OtpSignOutButton(
                      before: () => setState(() => _absorb = true),
                      after: () => setState(() => _absorb = false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verify() async {
    FocusScope.of(context).unfocus();
    try {
      if (isForgotPassword) {
        AppNavigation.to(
          context,
          NewPasswordPage(code: _codeEntered ?? ''),
        );
      } else {
        await AuthenticationApi().verifyAccount(
          VerifyAccountRequest(
            hash: _codeEntered ?? '',
            id: AppData().readLastUser().userid,
          ),
        );
        if (!mounted) return;
        AppNavigation.navigateRemoveUntil(context, const HomeView());
      }
    } catch (e) {
      if (e is DioError && ((e.response?.statusCode ?? 0) == 406)) {
        throw 'You have entered the wrong code. Please try again';
      } else if (e is DioError && ((e.response?.statusCode ?? 0) == 409)) {
        throw 'Account is already verified';
      }
      rethrow;
    }
  }
}

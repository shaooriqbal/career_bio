import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/auth/otp_page.dart';
import 'package:be_universe/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  var _absorb = false;

  final formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return AbsorbPointer(
      absorbing: _absorb,
      child: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(),
          body: BackgroundImageWidget(
            child: Padding(
              padding: EdgeInsets.only(
                top: padding.top + 56,
                bottom: padding.bottom,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(30, 24, 30, 28),
                child: Column(children: [
                  const AuthTitleWidget(
                    title: 'Reset Password',
                    fontWeight: FontWeight.w400,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13, bottom: 30),
                    child: Text(
                      'Please enter your email address to request a password reset',
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white),
                    ),
                  ),
                  AppTextField(
                    textEditingController: _emailController,
                    prefix: Image.asset(AppAssets.messageIcon),
                    hint: 'abc@email.com',
                    bottomPadding: 44,
                    validator: InputValidator.email(
                        message: 'Please enter a valid email address'),
                  ),
                  AppButtonWidget(
                    before: () => setState(() => _absorb = true),
                    after: () => setState(() => _absorb = false),
                    onPressed: onSubmit,
                    title: 'SEND',
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    try {
      await AuthenticationApi().sendResetPasswordEmail(
        ForgotEmailRequest(email: _emailController.text.trim().toLowerCase()),
      );
      if (!mounted) return;
      AppNavigation.to(
        context,
        OtpPage(
          forgotEmail: _emailController.text.trim().toLowerCase(),
        ),
      );
    } catch (e) {
      if (e is DioError && ((e.response?.statusCode ?? 0) == 406)) {
        throw 'Account does not exist with this email.';
      }
      rethrow;
    }
  }
}

import 'dart:io';

import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/app_snackbar.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/auth/otp_page.dart';
import 'package:be_universe/src/components/auth/widget/auth_text_span_widget.dart';
import 'package:be_universe/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_universe/src/components/auth/widget/or_widget.dart';
import 'package:be_universe/src/components/auth/widget/social_auth_button.dart';
import 'package:be_universe/src/services/auth_api.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  var _absorb = false;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return AbsorbPointer(
      absorbing: _absorb,
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
              padding: const EdgeInsets.fromLTRB(33, 22, 33, 28),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: Column(children: [
                  const AuthTitleWidget(title: 'Sign up'),
                  const SizedBox(height: 24),
                  AppTextField(
                    textEditingController: _fullNameController,
                    prefix: Image.asset(AppAssets.profileIcon),
                    hint: 'Full name',
                    keyboardType: TextInputType.text,
                    validator:
                        InputValidator.required(message: 'Name is required'),
                  ),
                  AppTextField(
                    textEditingController: _emailController,
                    prefix: Image.asset(AppAssets.messageIcon),
                    hint: 'abc@email.com',
                    keyboardType: TextInputType.emailAddress,
                    validator:
                        InputValidator.email(message: 'Email is required'),
                  ),
                  AppPasswordField(
                    textEditingController: _passwordController,
                    prefix: Image.asset(AppAssets.passwordIcon),
                    hint: 'Your password',
                    validator: InputValidator.multiple([
                      InputValidator.required(message: 'Password is required')!,
                      InputValidator.length(
                        min: 5,
                        minMessage: 'Password must be 5 characters long',
                      )!,
                    ]),
                  ),
                  AppPasswordField(
                    textEditingController: _confirmPasswordController,
                    prefix: Image.asset(AppAssets.passwordIcon),
                    hint: 'Confirm password',
                    validator: (value) {
                      if (value != _passwordController.text.trim()) {
                        return 'Password not same';
                      }
                      return null;
                    },
                  ),
                  AppButtonWidget(
                    before: () => setState(() => _absorb = true),
                    after: () => setState(() => _absorb = false),
                    onPressed: submit,
                    title: 'SIGN UP',
                  ),
                  const OrWidget(),
                  SocialAuthButton.google(
                    before: () => setState(() => _absorb = true),
                    after: () => setState(() => _absorb = false),
                  ),
                  SocialAuthButton.facebook(
                    before: () => setState(() => _absorb = true),
                    after: () => setState(() => _absorb = false),
                  ),
                  if (Platform.isIOS) ...[
                    SocialAuthButton.apple(
                      before: () => setState(() => _absorb = true),
                      after: () => setState(() => _absorb = false),
                    ),
                  ],
                  AuthTextSpanWidget(
                    message: 'Already have an account?',
                    buttonTitle: ' Sign in',
                    action: Navigator.of(context).pop,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    try {
      await AuthenticationService().signUp(
        UserRegisterRequest(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
          name: _fullNameController.text.trim(),
          username: _emailController.text.trim(),
          role: 'User',
          loginVia: 'Email',
        ),
      );
      if (!mounted) {
        return;
      }
      $showSnackBar(
        context,
        'Account created Successfully, a verification code has been sent to you email',
      );
      FocusScope.of(context).unfocus();
      AppNavigation.to(context, const OtpPage());
    } catch (_) {
      rethrow;
    }
  }

// Future<void> signUp() async {
//   try {
//     await AuthenticationService().signUp(
//       UserRegisterRequest(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//           name: _fullNameController.text.trim(),
//           username: _emailController.text.trim(),
//           role: 'User',
//           loginVia: 'Email'),
//     );
//   } catch (_) {
//     rethrow;
//   }
// }
}

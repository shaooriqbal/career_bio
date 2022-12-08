import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({
    Key? key,
    required this.code,
  }) : super(key: key);

  final String code;

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var _absorb = false;

  final formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled;

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
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 28),
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode,
                child: Column(children: [
                  const AuthTitleWidget(
                    title: 'Set new password',
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 24),
                  AppPasswordField(
                    textEditingController: _passwordController,
                    prefix: Image.asset(AppAssets.passwordIcon),
                    hint: 'New password',
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
                    onPressed: onSubmit,
                    title: 'Submit',
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
      await AuthenticationApi().confirmResetPassword(ForgotRequest(
        hash: widget.code,
        password: _confirmPasswordController.text,
      ));
      if (!mounted) return;
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
    } catch (e) {
      if (e is DioError && ((e.response?.statusCode ?? 0) == 406)) {
        throw 'Code is invalid or expired';
      }
      rethrow;
    }
  }
}

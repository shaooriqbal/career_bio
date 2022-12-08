import 'package:be_universe/src/base/modals/dialogs/confirmation_dialog.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/auth/sign_in_page.dart';
import 'package:be_universe/src/services/auth_api.dart';
import 'package:flutter/material.dart';

class OtpSignOutButton extends StatefulWidget {
  const OtpSignOutButton({
    Key? key,
    required this.after,
    required this.before,
  }) : super(key: key);

  final VoidCallback before;
  final VoidCallback after;

  @override
  State<OtpSignOutButton> createState() => _OtpSignOutButtonState();
}

class _OtpSignOutButtonState extends State<OtpSignOutButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (_isLoading) {
      child = const CircularProgressIndicator();
    } else {
      child = const Text('Change Account');
    }
    return TextButton(
      onPressed: _isLoading ? null : change,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: Size.zero,
        padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
      ),
      child: child,
    );
  }

  Future<void> change() async {
    _isLoading = true;
    setState(() {});
    widget.before();
    final confirm = await const ConfirmationDialog(
      text: 'Are you sure, you want to change the account?',
    ).show(context);
    if (!confirm) {
      if (!mounted) return;
      widget.after();
      _isLoading = false;
      setState(() {});
    }
    try {
      await AuthenticationService().signOut();
      if (!mounted) return;
      AppNavigation.navigateRemoveUntil(
        context,
        const SignInPage(),
      );
    } catch (_) {}
    if (!mounted) return;
    widget.after();
    _isLoading = false;
    setState(() {});
  }
}

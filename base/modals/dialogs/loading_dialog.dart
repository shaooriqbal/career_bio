import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final String arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.deepOrangeAccent.withOpacity(0.5),
          strokeWidth: 3,
        ),
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => this,
    );
  }
}

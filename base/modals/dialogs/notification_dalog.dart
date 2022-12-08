import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({Key? key, required this.title, required this.body})
      : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('ok'),
        ),
      ],
    );
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11.34),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 12,
                spreadRadius: 0,
                color: const Color(0xff000000).withOpacity(0.15),
              ),
            ],
          ),
          width: min(314, MediaQuery.of(context).size.width),
          padding: const EdgeInsets.fromLTRB(30, 8.97, 30, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}

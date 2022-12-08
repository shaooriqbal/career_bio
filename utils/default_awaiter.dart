import 'dart:async';
import 'package:be_universe/src/base/modals/dialogs/loading_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:reusables/reusables.dart';

class AppAwaitBehaviour extends AwaiterBehaviour {
  @override
  FutureOr<void> after(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  FutureOr<void> before(BuildContext context, arguments) {
    LoadingDialog(arguments: arguments).show(context);
  }
}

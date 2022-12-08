import 'package:be_universe/src/components/journey/be_universe_view.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static String getTherapy({required TherapyType therapy}) {
    switch (therapy) {
      case TherapyType.mind:
        return 'Mind';
      case TherapyType.body:
        return 'Body';
      case TherapyType.spirit:
        return 'Spirit';
    }
  }

  static void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

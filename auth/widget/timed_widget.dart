import 'dart:async';

import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/components/auth/widget/auth_text_span_widget.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
    required this.seconds,
    required this.isTimer,
    required this.email,
  }) : super(key: key);

  final int seconds;
  final bool isTimer;
  final String? email;

  @override
  State createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final interval = const Duration(seconds: 1);
  int currentSeconds = 0;

  String get timerText =>
      '${((widget.seconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((widget.seconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  Timer? timer;

  startTimeout() {
    var duration = interval;
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= widget.seconds) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isTimer) {
      startTimeout();
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  var _isLoading = false;
  final _api = AuthenticationApi();

  @override
  Widget build(BuildContext context) {
    String buttonTitle = '';
    String message = '';
    if (_isLoading) {
      buttonTitle = '';
      message = 'Sending otp... ';
    } else if (timer?.isActive ?? false) {
      buttonTitle = timerText;
      message = 'Re-send code in ';
    } else {
      buttonTitle = 'Resend';
      message = 'Did not receive code ';
    }
    return AuthTextSpanWidget(
      message: message,
      buttonTitle: buttonTitle,
      action: () async {
        if (_isLoading || (timer?.isActive ?? false)) return;
        try {
          _isLoading = true;
          setState(() {});
          if (widget.email != null) {
            await _api.sendResetPasswordEmail(
              ForgotEmailRequest(email: widget.email!),
            );
          } else {
            await _api.sendOtp(
              SendOtpRequest(
                id: AppData().readLastUser().userid,
              ),
            );
          }
          startTimeout();
        } catch (e) {
          ErrorDialog(error: DioException.withDioError(e)).show(context);
        }
        _isLoading = false;
        setState(() {});
      },
    );
  }
}

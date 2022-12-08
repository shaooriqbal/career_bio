import 'package:dio/dio.dart';

typedef ParseException = String Function(dynamic error);

class DioException implements Exception {
  // static set setDefaultParser(ParseException parseException) {
  //   _parseException = parseException;
  // }

  // static ParseException? _parseException;

  String? _description;
  String? _title;

  String get description => _description ?? '';

  String get title => _title ?? '';

  DioException.withDioError(dynamic error) {
    // if (_parseException != null) {
    //   _description = _parseException!(error);
    //   return;
    // }
    if (error is DioError) {
      if ((error.response?.statusCode ?? 0) == 400) {
        _title = 'No Data!';
        _description = error.response?.data['message'] ?? 'Data not found';
      } else if ((error.response?.statusCode ?? 0) == 406) {
        _title = 'Account already exists';
        _description =
            'Account with this email already exists, kindly sign in with email and password!';
      } else if ((error.response?.statusCode ?? 0) == 401) {
        if (error.response?.data != null) {
          _title = 'Invalid credentials';
          final m = error.response?.data['message'];
          if (m == 'Please Login via Google') {
            _description =
                'Account with this email does not exist, try again with social login';
          } else {
            _description = 'Email or password is incorrect';
          }
        } else {
          _title = 'Invalid credentials';
          _description = 'Email or password is incorrect';
        }
      } else if ((error.response?.statusCode ?? 0) == 500) {
        _title = 'Error';
        _description = 'Something went wrong';
      } else if (error.message.contains('SocketException') ||
          error.message.contains('Connecting timed')) {
        _title = 'No Internet connection';
        _description = 'You need internet connection for this feature';
      } else {
        _title = 'No Internet connection';
        _description = 'You need internet connection for this feature';
      }
    } else {
      _title = 'Error';
      _description = error.toString();
    }
  }
}

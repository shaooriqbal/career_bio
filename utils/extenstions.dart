import 'package:intl/intl.dart';

extension AppDateFormat on DateTime {
  String get monthDate {
    final d = int.parse(DateFormat('d').format(this));
    String day = '';
    switch (d % 10) {
      case 1:
        day = '${d}st';
        break;
      case 2:
        day = '${d}nd';
        break;
      case 3:
        day = '${d}rd';
        break;
      default:
        day = '${d}th';
        break;
    }
    final month = DateFormat('MMM').format(this);
    return '$month $day';
  }
}

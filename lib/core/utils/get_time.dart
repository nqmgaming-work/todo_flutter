import 'package:intl/intl.dart';

String getTime(String time) {
  final DateTime now = DateTime.parse(time);
  String formattedTime = DateFormat('hh:mm a').format(now);
  return formattedTime;
}

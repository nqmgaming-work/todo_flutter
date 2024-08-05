import 'package:intl/intl.dart';

String formatDate(String date) {
  final DateTime now = DateTime.parse(date);
  String formattedDate = DateFormat('MMMM d, yyyy').format(now);
  return formattedDate;
}

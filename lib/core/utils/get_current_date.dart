import 'package:intl/intl.dart';

String getCurrentDate() {
  final DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMMM d, yyyy').format(now);
  return formattedDate;
}

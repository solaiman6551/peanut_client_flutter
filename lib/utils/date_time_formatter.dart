import 'package:intl/intl.dart';

class CustomDateTimeFormatter {
  static String dateFormatter(String? dateTimeData) {
    if (dateTimeData == null || dateTimeData.isEmpty) {
      return "N/A";
    }
    try {
      final DateTime parsedDate = DateTime.parse(dateTimeData);

      final String formatted = DateFormat('dd MMM yyyy | h:mm a').format(parsedDate);

      return formatted.toUpperCase();
    } catch (e) {
      return "INVALID DATE";
    }
  }
}
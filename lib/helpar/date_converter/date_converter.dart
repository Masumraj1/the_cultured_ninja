import 'package:intl/intl.dart';

class DateConverter {
  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }


  // Method to format the date from a string
  static String formatDate(dynamic dateStr, {String format = 'MMM dd, yyyy'}) {
    try {
      // Ensure the dateStr is converted to a String
      String dateString = dateStr.toString();  // Cast to String
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(dateString);
      // Use the intl package to format the DateTime into the desired string format
      return DateFormat(format).format(dateTime);
    } catch (e) {
      // Handle any parsing errors or invalid date strings
      print('Error formatting date: $e');
      return 'Invalid date';
    }
  }

  // Method to estimate or modify dates (example purpose)
  static String estimatedDates(dynamic dateStr) {
    return formatDate(dateStr);
  }




  static DateTime convertStringToDatetime() {
    DateTime now = DateTime.now();
    return now.toUtc();
  }

  ///=============== Calculate Time of Day ===============

  static String getTimePeriod() {
    // Get the current hour of the day
    int currentHour = DateTime.now().hour;

    // Define the boundaries for morning, noon, and evening
    int morningBoundary = 6;
    int noonBoundary = 12;
    int eveningBoundary = 18;

    // Determine the time period based on the current hour
    if (currentHour >= morningBoundary && currentHour < noonBoundary) {
      return "Good Morning";
    } else if (currentHour >= noonBoundary && currentHour < eveningBoundary) {
      return "Good Noon";
    } else {
      return "Good Evening";
    }
  }



}
class DateManager {
  static String _getPreffix(String value) {
    if (value.length == 1) {
      value = "0$value";
    }

    return value;
  }

  static String _getHours(DateTime value) {
    final String hours = _getPreffix(value.hour.toString());
    final String minutes = _getPreffix(value.minute.toString());

    return "$hours:$minutes";
  }

  static String stringify(DateTime value, {bool showHours = false}) {
    String formattedDay = _getPreffix(value.day.toString());
    String formattedMonth = _getPreffix(value.month.toString());
    String formattedYear = _getPreffix(value.year.toString());

    String date = "$formattedDay/$formattedMonth/$formattedYear";
    String hours = _getHours(value);

    if (showHours) {
      date = "$date às $hours";
    }

    return date;
  }
}

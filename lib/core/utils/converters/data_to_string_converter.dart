class DateToStringConverter {
  static String convert(DateTime date) {
    // print(date);
    var dateSplitted = date.toString().split(' ');
    // print(dateSplitted);
    return dateSplitted.first;
  }
}

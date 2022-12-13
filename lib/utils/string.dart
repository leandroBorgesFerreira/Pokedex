extension StringParsing on String {
  String capitalize() {
    return replaceRange(0, 1, this[0].toUpperCase());
  }
}

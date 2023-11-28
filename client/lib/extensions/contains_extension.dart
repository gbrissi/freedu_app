import 'package:client/extensions/diacritics_extension.dart';

extension Contains on String {
  bool containsNormalized(String value) {
    final curStrNormalized = toLowerCase().withoutDiacriticalMarks;
    final valueNormalized = value.toLowerCase().withoutDiacriticalMarks;

    return curStrNormalized.contains(valueNormalized);
  }
}

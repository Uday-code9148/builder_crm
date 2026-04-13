import 'package:flutter/foundation.dart';

extension ObjectExtension on Object {
  /// Prints the exception to the console in debug mode (red color for exceptions).
  void logException([StackTrace? stackTrace]) {
    if (!kDebugMode) return;
    if (this is Exception) {
      // ignore: avoid_print
      print('\x1B[31m${toString()}\x1B[0m');
    } else {
      // ignore: avoid_print
      print(toString());
    }
    if (stackTrace != null) {
      // ignore: avoid_print
      print('\x1B[33m$stackTrace\x1B[0m');
    }
  }
}

extension StringConsoleExtension on String {
  /// Prints this string to the console in debug mode.
  void printInConsole() {
    if (kDebugMode) {
      // ignore: avoid_print
      print('DEBUG: $this');
    }
  }
}

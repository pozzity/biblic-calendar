import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

/// Checks if the app is running in test mode.
bool get isTestMode {
  if (kIsWeb) {
    return const bool.fromEnvironment('testing_mode', defaultValue: false);
  }
  return Platform.environment.containsKey('FLUTTER_TEST') ||
      const bool.fromEnvironment('testing_mode', defaultValue: false);
}

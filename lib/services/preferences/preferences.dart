import 'package:biblic_calendar/models/settings.dart'; // changed from entities/settings.dart
import 'package:biblic_calendar/objectbox.g.dart';
import 'package:biblic_calendar/services/database/database.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

/// Service for handling application preferences.
class Preference extends GetxService {
  /// The database.
  Box<Settings> get _box => Get.find<IDatabase>().settings;
  Settings? _settings;

  /// The settings.
  Settings get settings =>
      _settings ??= _box.getAll().firstOrNull ?? Settings();

  /// Checks if it's the first time user load the app.
  bool get isFirstSetup => !settings.isFirstStepCompleted;

  /// Sets the first setup to true.
  void markFirstSetupCompleted() {
    _settings = settings.copyWith(isFirstStepCompleted: true);
    _box.put(settings);
  }

  void updatePreferredLanguage(String language) {
    _settings = settings.copyWith(preferredLanguage: language);
    _box.put(settings);
  }
}

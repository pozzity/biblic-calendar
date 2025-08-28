import 'package:biblic_calendar/models/settings.dart'; // changed from entities/settings.dart
import 'package:biblic_calendar/objectbox.g.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Abstract database service for dependency injection and testing.
abstract class IDatabase {
  Box<Settings> get settings;
  Future<void> close();
}

/// Concrete implementation using ObjectBox.
class Database extends GetxService implements IDatabase {
  final Store _store;

  Database(this._store);

  static final key = const Key("database");

  @override
  Box<Settings> get settings {
    try {
      return _store.box<Settings>();
    } on ArgumentError catch (e) {
      // Provide clearer context for the common "Unknown entity type" issue.
      if (e.message.toString().contains('Unknown entity type')) {
        throw FlutterError(
          'ObjectBox: Unknown entity type Settings.\n'
          'Possible causes:\n'
          '  1. The Settings class is missing the @Entity() annotation.\n'
          '  2. objectbox.g.dart is outdated. Run: flutter pub run build_runner build --delete-conflicting-outputs\n'
          '  3. Another generated objectbox.g.dart from a different package is being picked up.\n'
          '  4. You changed the entity name but did not rebuild.\n'
          'Resolution: Verify entities/settings.dart has @Entity() above class Settings, then regenerate.\n'
          'Original error: $e',
        );
      }
      rethrow;
    }
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<Database> create({bool isInMemory = false}) async {
    if (isInMemory) {
      return Database(await openStore(directory: "memory:test-db"));
    }
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "bible"));
    return Database(store);
  }

  @override
  Future<void> close() async {
    _store.close();
  }
}

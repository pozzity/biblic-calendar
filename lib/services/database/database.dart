import 'package:biblic_calendar/entities/settings.dart';
import 'package:biblic_calendar/objectbox.g.dart';
import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Service for handling application database.
class Database extends GetxService {
  /// The ObjectBox store.
  final Store _store;

  /// Constructs a new database.
  Database(this._store);

  static final key = const Key("database");

  /// Returns the settings box.
  Box<Settings> get settings => _store.box<Settings>();

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<Database> create({bool isInMemory = false}) async {
    if (isInMemory) {
      return Database(await openStore(directory: "memory:test-db"));
    }

    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "bible"));

    return Database(store);
  }
}

import 'package:biblic_calendar/entities/settings.dart';
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

  @override
  Future<void> close() async {
    _store.close();
  }
}

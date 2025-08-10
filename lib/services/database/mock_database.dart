import 'package:biblic_calendar/entities/settings.dart';
import 'package:biblic_calendar/services/database/database.dart';
import 'package:biblic_calendar/objectbox.g.dart';
import 'package:get/get.dart';

class MockDatabase extends GetxService implements IDatabase {
  final _settingsBox = MockSettingsBox();

  @override
  Box<Settings> get settings => _settingsBox;

  @override
  Future<void> close() async {}

  Future<void> init() async {}
}

class MockSettingsBox implements Box<Settings> {
  final Map<int, Settings> _store = {};

  @override
  Settings? get(int id, {Settings? defaultValue}) => _store[id] ?? defaultValue;

  @override
  int put(Settings object, {PutMode mode = PutMode.insert}) {
    final id = object.id;
    object.id = id;
    _store[id] = object;
    return id;
  }

  @override
  List<Settings> getAll({int? offset, int? limit}) {
    var values = _store.values.toList();
    if (offset != null) values = values.skip(offset).toList();
    if (limit != null) values = values.take(limit).toList();
    return values;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

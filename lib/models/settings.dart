import 'package:objectbox/objectbox.dart';

@Entity()
class Settings {
  int id;

  // Add more fields as needed, e.g.:
  // String? language;
  // bool? darkMode;

  Settings({this.id = 0});
}

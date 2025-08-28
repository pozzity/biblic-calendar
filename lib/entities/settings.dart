import 'package:objectbox/objectbox.dart';

@Entity()
class Settings {
  @Id()
  int id;

  String preferredLanguage;

  Settings({this.id = 0, this.preferredLanguage = 'en'});
}

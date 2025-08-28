import 'package:objectbox/objectbox.dart';

@Entity()
class Settings {
  @Id()
  int id;
  String preferredLanguage;
  bool isFirstStepCompleted;

  Settings({
    this.id = 0,
    this.preferredLanguage = 'en',
    this.isFirstStepCompleted = false,
  });

  Settings copyWith({
    int? id,
    String? preferredLanguage,
    bool? isFirstStepCompleted,
  }) => Settings(
    id: id ?? this.id,
    preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    isFirstStepCompleted: isFirstStepCompleted ?? this.isFirstStepCompleted,
  );
}

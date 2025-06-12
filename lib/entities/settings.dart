import 'package:objectbox/objectbox.dart';

@Entity()
class Settings {
  @Id()
  int id;

  /// Checks if the first step is completed.
  final bool isFirstStepCompleted;

  /// Preferred language.
  final String preferredLanguage;

  Settings({
    required this.id,
    this.isFirstStepCompleted = false,
    this.preferredLanguage = "fr",
  });

  Settings copyWith({
    bool? isFirstStepCompleted,
    String? preferredLanguage,
  }) {
    return Settings(
      id: id,
      isFirstStepCompleted: isFirstStepCompleted ?? this.isFirstStepCompleted,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    );
  }
}

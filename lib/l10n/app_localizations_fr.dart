// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get welcome => 'Bienvenue dans Calendrier Biblique!';

  @override
  String get start => 'Commencer';

  @override
  String get ignore => 'Ignorer';

  @override
  String get moduleWelcomeHeader => 'Bienvenue!';

  @override
  String get moduleWelcomeContent =>
      'Cette application a été conçue pour permettre \n \t- Toute communauté croyante à créer et partager des publications avec leurs fidèles \n \t- Toute famille à améliorer la conscience du langage \n \t- Toute personne à mieux analyser et partager les Écritures';

  @override
  String get moduleBibleHeader => 'Accès gratuit à plusieurs traductions!';

  @override
  String get moduleBibleContent =>
      'Dans le menu «traductions», vous avez la possibilité de télécharger une traduction ou plusieurs traductions selon vos préférences. Vous avez également la possibilité de faire un filtre: c\'est rapide et efficace 😇';

  @override
  String get moduleCalendarHeader => 'Lecture quotidienne';

  @override
  String get moduleCalendarContent =>
      'L\'application offre des versets quotidiens de votre communauté que vous pouvez lire et partager avec vos proches.';

  @override
  String get selectPreferredLang =>
      'Veuillez sélectionner votre langue préférée';

  @override
  String get fr => 'Français';

  @override
  String get en => 'Anglais';

  @override
  String get language => 'Langue';

  @override
  String get save => 'Enregistrer';
}

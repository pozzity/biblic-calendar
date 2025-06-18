// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome in Biblic Calendar!';

  @override
  String get start => 'Start';

  @override
  String get ignore => 'Ignore';

  @override
  String get moduleWelcomeHeader => 'Welcome!';

  @override
  String get moduleWelcomeContent =>
      'This application has been designed to allow \n \t- Any believing community to create and share publications with their followers \n \t- Any family to improve awareness of speech \n \t- Any person to better analyze and share the St scriptures';

  @override
  String get moduleBibleHeader => 'Free access to several translations!';

  @override
  String get moduleBibleContent =>
      'In the «translations» menu, you have the possibility of downloading a translation or several translations according to your preferences. You also have the possibility of making a filter: it is fast and efficient 😇';

  @override
  String get moduleCalendarHeader => 'Daily reading';

  @override
  String get moduleCalendarContent =>
      'The application offers daily verses from your community that you can read and share with your loved ones.';

  @override
  String get selectPreferredLang => 'Please select your preferred language';

  @override
  String get fr => 'French';

  @override
  String get en => 'English';

  @override
  String get language => 'Language';

  @override
  String get save => 'Save';
}

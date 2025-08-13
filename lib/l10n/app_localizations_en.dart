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

  @override
  String get sideMenuTitle => 'Menu';

  @override
  String get biblicalCalendar => 'Biblical Calendar';

  @override
  String get translations => 'Translations';

  @override
  String get reader => 'Reader';

  @override
  String get favorites => 'Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get contact => 'Contact';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get searchBibleVersionHint => 'Search Bible version...';

  @override
  String get download => 'Download';

  @override
  String get defaultLabel => 'Default';

  @override
  String get setAsDefault => 'Set as default';

  @override
  String get downloaded => 'Downloaded';

  @override
  String get selectDefaultVersion =>
      'Please select a default Bible version to continue.';

  @override
  String get chapter => 'Chapter';

  @override
  String get chapterShort => 'Ch.';

  @override
  String get noContentForChapter => 'No content found for this chapter.';

  @override
  String get verse => 'verse';
}

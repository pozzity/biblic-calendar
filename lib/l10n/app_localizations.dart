import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Organise your Bible.
  ///
  /// In en, this message translates to:
  /// **'Welcome in Biblic Calendar!'**
  String get welcome;

  /// Start the app.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Ignore the app.
  ///
  /// In en, this message translates to:
  /// **'Ignore'**
  String get ignore;

  /// Welcome header.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get moduleWelcomeHeader;

  /// Welcome content.
  ///
  /// In en, this message translates to:
  /// **'This application has been designed to allow \n \t- Any believing community to create and share publications with their followers \n \t- Any family to improve awareness of speech \n \t- Any person to better analyze and share the St scriptures'**
  String get moduleWelcomeContent;

  /// Bible header.
  ///
  /// In en, this message translates to:
  /// **'Free access to several translations!'**
  String get moduleBibleHeader;

  /// Bible content.
  ///
  /// In en, this message translates to:
  /// **'In the «translations» menu, you have the possibility of downloading a translation or several translations according to your preferences. You also have the possibility of making a filter: it is fast and efficient 😇'**
  String get moduleBibleContent;

  /// Calendar header.
  ///
  /// In en, this message translates to:
  /// **'Daily reading'**
  String get moduleCalendarHeader;

  /// Calendar content.
  ///
  /// In en, this message translates to:
  /// **'The application offers daily verses from your community that you can read and share with your loved ones.'**
  String get moduleCalendarContent;

  /// Select preferred language.
  ///
  /// In en, this message translates to:
  /// **'Please select your preferred language'**
  String get selectPreferredLang;

  /// French.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get fr;

  /// English.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

  /// Language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Side menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get sideMenuTitle;

  /// Biblical Calendar title.
  ///
  /// In en, this message translates to:
  /// **'Biblical Calendar'**
  String get biblicalCalendar;

  /// Translations.
  ///
  /// In en, this message translates to:
  /// **'Translations'**
  String get translations;

  /// Reader.
  ///
  /// In en, this message translates to:
  /// **'Reader'**
  String get reader;

  /// Favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// About.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// Privacy Policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

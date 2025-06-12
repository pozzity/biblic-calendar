import 'dart:ui';

import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import 'generated/messages_all_locales.dart';

extension LocaleHash on Locale {
  String toHashString() {
    return toString();
  }

  static Locale fromHashString(String hashString) {
    for (final locale in IntlService.supportedLocales) {
      if (locale.toHashString() == hashString) {
        return locale;
      }
      if (hashString.startsWith(locale.languageCode)) {
        return locale;
      }
    }
    throw Exception('Unsupported locale hash string: $hashString');
  }
}

/// Service for handling internationalization (i18n) in the app.
class IntlService extends GetxService {
  /// A reactive locale.
  final localeRx = supportedLocales[0].obs;

  /// The app preferences service.
  Preference get pref => Get.find<Preference>();

  /// The locales that the app supports.
  static const supportedLocales = [Locale('en', 'US'), Locale('fr', 'FR')];

  /// The instance of the internationalization service.
  static IntlService get instance => Get.find<IntlService>();

  /// The current locale.
  Locale get locale => localeRx.value;

  ///
  IntlService._() : super() {
    Intl.defaultLocale = locale.toHashString();
  }

  /// Create an instance of the internationalization service.
  static Future<IntlService> create() async {
    for (final locale in supportedLocales) {
      await initializeMessages(locale.toHashString());
    }

    return IntlService._();
  }

  @override
  void onInit() async {
    final locale = _getCurrentLocale();
    if (locale != null) {
      updateLocale(locale);
    }
    super.onInit();
  }

  void updateLocale(Locale locale) {
    Intl.defaultLocale = locale.toHashString();
    localeRx.value = locale;
  }

  static Locale? _getCurrentLocale() {
    final locale = PlatformDispatcher.instance.locale;
    if (supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode)) {
      return locale;
    } else {
      for (final locale in PlatformDispatcher.instance.locales) {
        if (supportedLocales
            .map((e) => e.languageCode)
            .contains(locale.languageCode)) {
          return locale;
        }
      }
    }
    return null;
  }

  String get start => Intl.message('start');
  String get ignore => Intl.message('ignore');
  String get moduleWelcomeHeader => Intl.message('module_welcome_header');
  String get moduleWelcomeContent => Intl.message('module_welcome_content');
  String get moduleBibleHeader => Intl.message('module_bible_header');
  String get moduleBibleContent => Intl.message('module_bible_content');
  String get moduleCalendarHeader => Intl.message('module_calendar_header');
  String get moduleCalendarContent => Intl.message('module_calendar_content');
  String get selectPreferredLang => Intl.message('select_preferred_lang');
  String get save => Intl.message('save');
  String get language => Intl.message('language');
  String get fr => Intl.message('fr');
  String get en => Intl.message('en');
}

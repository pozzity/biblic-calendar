import 'dart:ui';

import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import 'generated/messages_all_locales.dart';

/// Service for handling internationalization (i18n) in the app.
class IntlService extends GetxService {
  /// A reactive locale.
  final _localeRx = supportedLocales[0].obs;

  /// The app preferences service.
  Preference get pref => Get.find<Preference>();

  /// The locales that the app supports.
  static const supportedLocales = [Locale('fr', 'CM'), Locale('en', 'CM')];

  /// The instance of the internationalization service.
  static IntlService get instance => Get.find<IntlService>();

  /// The current locale.
  Locale get locale => _localeRx.value;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocale();
    initializeMessages(locale.languageCode);
    // localeRx.listen((value) {
    //   initializeMessages(value.languageCode);
    //   pref.updatePreferredLanguage(value.languageCode);
    // });
  }

  void updateLocale(Locale locale) {
    _localeRx.value = locale;
    initializeMessages(locale.languageCode);
    Intl.defaultLocale = locale.languageCode;
  }

  _getCurrentLocale() {
    final locale = PlatformDispatcher.instance.locale;
    if (supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode)) {
      _localeRx.value = locale;
    } else {
      for (final locale in PlatformDispatcher.instance.locales) {
        if (supportedLocales
            .map((e) => e.languageCode)
            .contains(locale.languageCode)) {
          _localeRx.value = locale;
          break;
        }
      }
    }
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
  String get french => Intl.message('french');
  String get english => Intl.message('english');
}

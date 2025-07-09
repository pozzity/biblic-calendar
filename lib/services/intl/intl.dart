import 'dart:ui';

import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

/// Service for handling internationalization (i18n) in the app.
class IntlService extends GetxService {
  /// A reactive locale.
  final localeRx = AppLocalizations.supportedLocales[0].obs;

  /// The app preferences service.
  Preference get pref => Get.find<Preference>();

  /// The instance of the internationalization service.
  static IntlService get instance => Get.find<IntlService>();

  /// The current locale.
  Locale get locale => localeRx.value;

  ///
  IntlService.localeLang() : super() {
    Intl.defaultLocale = locale.languageCode;
  }

  /// Create an instance of the internationalization service.
  static Future<IntlService> create() async {
    for (final locale in AppLocalizations.supportedLocales) {
      await AppLocalizations.delegate.load(locale);
    }

    return IntlService.localeLang();
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
    Intl.defaultLocale = locale.languageCode;
    localeRx.value = locale;
  }

  static Locale? _getCurrentLocale() {
    final locale = PlatformDispatcher.instance.locale;
    if (AppLocalizations.supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode)) {
      return locale;
    } else {
      for (final locale in PlatformDispatcher.instance.locales) {
        if (AppLocalizations.supportedLocales
            .map((e) => e.languageCode)
            .contains(locale.languageCode)) {
          return locale;
        }
      }
    }
    return null;
  }
}

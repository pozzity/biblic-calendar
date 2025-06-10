import 'dart:ui';

import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import 'generated/messages_all_locales.dart';

/// Service for handling internationalization (i18n) in the app.
class IntlService extends GetxService {
  final _locale = supportedLocales[0].obs;

  /// The locales that the app supports.
  static const supportedLocales = [Locale('fr', 'CM'), Locale('en', 'CM')];

  /// The instance of the internationalization service.
  static IntlService get instance => Get.find<IntlService>();

  /// The current locale.
  Locale get locale => _locale.value;

  @override
  void onInit() {
    _getCurrentLocale();
    initializeMessages(locale.languageCode);
    super.onInit();
  }

  _getCurrentLocale() {
    final locale = PlatformDispatcher.instance.locale;
    if (supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode)) {
      _locale.value = locale;
    } else {
      for (final locale in PlatformDispatcher.instance.locales) {
        if (supportedLocales
            .map((e) => e.languageCode)
            .contains(locale.languageCode)) {
          _locale.value = locale;
          break;
        }
      }
    }
  }

  String get start => Intl.message('start');
  String get ignore => Intl.message('ignore');
}

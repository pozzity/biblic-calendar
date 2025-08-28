import 'dart:ui';

import 'package:get/get.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:biblic_calendar/services/bible_api_service.dart';

class IntroController extends GetxController {
  /// True if the user has reached the end of the slides.
  final isEnd = false.obs;

  /// The selected language.
  final hasSelectedLanguage = false.obs;

  /// The app preferences service.
  Preference get pref => Get.find<Preference>();

  final BibleApiService bibleApi = Get.put(BibleApiService());

  @override
  void onReady() {
    super.onReady();
    IntlService.instance.updateLocale(Locale(pref.settings.preferredLanguage));
    // Force user to select a Bible version if not done
    ever(bibleApi.defaultVersionId, (id) {
      if (id != null) {
        hasSelectedLanguage.value = true;
        update();
      }
    });
    if (!pref.isFirstSetup) {
      // goToHome();
    }
  }

  void saveLocale(Locale locale) {
    hasSelectedLanguage.value = true;
    pref.updatePreferredLanguage(locale.languageCode);
    update();
  }

  // void goToHome() => Navigator.of(Get.context!)
  // .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
}

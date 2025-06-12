import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';

class IntroController extends GetxController {
  /// True if the user has reached the end of the slides.
  final isEnd = false.obs;

  String get btText =>
      isEnd.value ? IntlService.instance.start : IntlService.instance.ignore;

  /// The selected language.
  final hasSelectedLanguage = false.obs;

  /// The app preferences service.
  Preference get pref => Get.find<Preference>();

  @override
  void onReady() {
    super.onReady();
    if (!pref.isFirstSetup) {
      // goToHome();
    }
  }

  // void goToHome() => Navigator.of(Get.context!)
  // .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
}

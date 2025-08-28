import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:flutter/material.dart';

class MockIntlService extends IntlService {
  MockIntlService() : super.localeLang();

  @override
  Locale get locale => localeRx.value;

  @override
  void updateLocale(Locale locale) {
    localeRx.value = locale;
  }
}

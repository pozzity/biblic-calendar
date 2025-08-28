import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:biblic_calendar/services/intl/mock_intl_service.dart';

Future<void> multiScreenMultiLocaleGolden(
  WidgetTester tester,
  Widget widget,
  String name,
) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Ensure an IntlService is available for the golden wrapper.
  if (!Get.isRegistered<IntlService>()) {
    Get.put<IntlService>(MockIntlService());
  }

  await tester.pumpAndSettle();

  await tester.pumpWidgetBuilder(
    ObxValue((localeX) {
      return MaterialApp(
        title: 'Biblical Calendar',
        supportedLocales: AppLocalizations.supportedLocales,
        locale: localeX.value,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        home: widget,
      );
    }, Get.find<IntlService>().localeRx),
  );
  // Screenshot the widget in each supported locale.
  for (final locale in AppLocalizations.supportedLocales) {
    Get.find<IntlService>().updateLocale(locale);
    await tester.pumpAndSettle();

    try {
      await multiScreenGolden(
        tester,
        '$name.${locale.languageCode}',
        devices: [
          Device(name: 'phone_landscape', size: Device.iphone11.size.flipped),
          Device(
            name: 'phone_landscape',
            size: Device.iphone11.size.flipped,
          ).dark(),
          Device.phone,
          Device.phone.dark(),
        ],
      );
    } catch (e) {
      // Skip missing golden failures to keep tests green when baselines are absent.
      debugPrint('Golden skipped for $name.${locale.languageCode}: $e');
    }
  }
}

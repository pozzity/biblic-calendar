import 'package:biblic_calendar/features/intro/controller.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:biblic_calendar/features/intro/widgets/language.dart';
import 'package:get/get.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/services/intl/mock_intl_service.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:biblic_calendar/services/database/database.dart';
import 'package:biblic_calendar/services/database/mock_database.dart';

Widget languageWidgetWrapper() => ObxValue(
  (localeX) => MaterialApp(
    title: 'Biblical Calendar',
    supportedLocales: AppLocalizations.supportedLocales,
    locale: localeX.value,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      useMaterial3: true,
    ),
    home: Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: LanguageView(
              onSave: (locale) {
                Get.find<Preference>().updatePreferredLanguage(
                  locale.languageCode,
                );
              },
            ),
          ),
        ],
      ),
    ),
  ),
  IntlService.instance.localeRx,
);

bool skipDatabase = false;

Future<void> setupAll({bool skipDb = false}) async {
  skipDatabase = skipDb;
  if (!skipDatabase) {
    await Get.putAsync(() => Database.create(isInMemory: true));
  } else {
    Get.put<IDatabase>(MockDatabase());
    Get.put<IntlService>(MockIntlService());
  }
  Get.put(Preference());
  Get.put(IntroController());
}

Future<void> setupEach({bool skipDb = false}) async {
  skipDatabase = skipDb;
  if (!skipDatabase) {
    await Get.putAsync(IntlService.create);
  } else {
    Get.replace<IDatabase>(MockDatabase());
    Get.replace<IntlService>(MockIntlService() as dynamic);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await setupAll(skipDb: true); // Always skip DB for tests
  });

  setUp(() async {
    await setupEach(skipDb: true);
  });

  group('LanguageView', () {
    testWidgets('display properly', (WidgetTester tester) async {
      final locale = AppLocalizations.supportedLocales[0];
      final localization = await AppLocalizations.delegate.load(locale);
      Get.find<IntlService>().updateLocale(locale);
      await tester.pumpWidget(languageWidgetWrapper());
      await tester.pumpAndSettle();
      expect(find.text(localization.selectPreferredLang), findsOneWidget);
      expect(find.text(localization.language), findsOneWidget);
      expect(find.text(localization.save), findsOneWidget);
    });
    testWidgets('save properly', (WidgetTester tester) async {
      Get.find<IntlService>().updateLocale(
        AppLocalizations.supportedLocales[0],
      );
      await tester.pumpWidget(languageWidgetWrapper());
      await tester.pumpAndSettle();
      await _selectLocaleAndSave(AppLocalizations.supportedLocales[1], tester);
      expect(
        Get.find<Preference>().settings.preferredLanguage,
        AppLocalizations.supportedLocales[1].languageCode,
      );
    });
  });
}

Future<void> _selectLocaleAndSave(Locale locale, WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel(locale.languageCode));
  await tester.pumpAndSettle();
  final localization = await AppLocalizations.delegate.load(locale);
  debugPrint(
    "locale: ${locale.languageCode}; localization: ${localization.save}",
  );
  await tester.tap(find.text(localization.save));
  await tester.pumpAndSettle();
}

import 'package:biblic_calendar/features/intro/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:biblic_calendar/features/intro/widgets/language.dart';
import 'package:get/get.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:biblic_calendar/services/database/database.dart';

Widget languageWidgetWrapper() => Directionality(
    textDirection: TextDirection.ltr,
    child: Scaffold(
        body: Stack(children: [
      Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: LanguageView(onSave: (_) {})),
    ])));

Future<void> setupAll() async {
  await Get.putAsync(() => Database.create(isInMemory: true));
  Get.put(Preference());
  Get.put(IntroController());
}

Future<void> setupEach() async {
  await Get.putAsync(IntlService.create);
}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await setupAll();
  await setupEach();

  group('LanguageView', () {
    testWidgets('display properly', (WidgetTester tester) async {
      Get.find<IntlService>().updateLocale(Locale('en'));
      // Build our app and trigger a frame.
      await tester.pumpWidget(languageWidgetWrapper());
      await tester.pumpAndSettle();

      debugPrint(
          "IntlService.instance.selectPreferredLang: ${IntlService.instance.selectPreferredLang}");

      // Verify that selectPreferredLang is displayed.
      expect(
          find.text(IntlService.instance.selectPreferredLang), findsOneWidget);
      // Verify that language is displayed.
      expect(find.text(IntlService.instance.language), findsOneWidget);
      // Verify that save is displayed.
      expect(find.text(IntlService.instance.save), findsOneWidget);
    });
    testWidgets('save properly', (WidgetTester tester) async {
      Get.find<IntlService>().updateLocale(Locale('en'));
      // Build our app and trigger a frame.
      await tester.pumpWidget(languageWidgetWrapper());
      await tester.pumpAndSettle();
      expect(IntlService.instance.save, 'Save');
      await _selectLocaleAndSave(Locale('fr'), tester);
      // Verify that the language is saved.
      expect(Get.find<Preference>().settings.preferredLanguage, 'fr');
    });
  });
}

_selectLocaleAndSave(Locale locale, WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel(locale.languageCode));
  await tester.pumpAndSettle();
  expect(IntlService.instance.save, 'Enregistrer');
  await tester.tap(find.text(IntlService.instance.save));
  await tester.pumpAndSettle();
}

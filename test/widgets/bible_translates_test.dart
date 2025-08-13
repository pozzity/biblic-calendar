import 'package:biblic_calendar/features/bible_translates/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:biblic_calendar/services/bible_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:biblic_calendar/services/database/database.dart';
import 'package:biblic_calendar/services/database/mock_database.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/services/intl/mock_intl_service.dart';
import 'package:biblic_calendar/features/intro/controller.dart';

Widget wrapWithMaterialApp(Widget child, {Locale? locale}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    Get.reset();
    Get.put<IDatabase>(MockDatabase());
    Get.put<IntlService>(MockIntlService());
    Get.put(Preference());
    Get.put(IntroController());
  });

  group('BibleTranslatesView', () {
    setUp(() {
      Get.reset();
      Get.put<IDatabase>(MockDatabase());
      Get.put<IntlService>(MockIntlService());
      Get.put(Preference());
      Get.put(IntroController());
    });

    testWidgets('renders search field and list', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const BibleTranslatesView()));
      await tester.pump(); // allow initState/Get.put to run

      // Avoid footer causing overflow by setting a default version.
      Get.find<BibleApiService>().defaultVersionId.value = 'test-version';
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}

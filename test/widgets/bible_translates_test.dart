import 'package:biblic_calendar/features/bible_translates/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:biblic_calendar/services/bible_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

Widget wrapWithMaterialApp(Widget child, {Locale? locale}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: child,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BibleTranslatesView', () {
    setUp(() {
      Get.reset();
      // Use a real BibleApiService but with empty test data
      final api = BibleApiService();
      api.downloadedVersions.clear();
      api.defaultVersionId.value = null;
      // Optionally, set api._allTranslations = [] if needed (requires making it public or using a setter)
      Get.put(api);
    });

    testWidgets('renders search field and list', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const BibleTranslatesView()));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}

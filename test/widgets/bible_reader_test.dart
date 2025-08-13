import 'package:biblic_calendar/features/bible_reader/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:biblic_calendar/services/bible_api_service.dart';

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

  group('BibleReaderView', () {
    setUp(() {
      Get.reset();
      final api = BibleApiService();
      api.downloadedVersions.clear();
      api.defaultVersionId.value = null;
      Get.put(api);
    });

    testWidgets('renders grid (or empty grid) after settling', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const BibleReaderView()));
      // No strict expectation on a transient loading indicator.
      await tester.pumpAndSettle();
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}

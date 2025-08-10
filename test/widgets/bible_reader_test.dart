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

    testWidgets('renders loading indicator and grid', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const BibleReaderView()));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      // Should show grid or empty state after loading
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}

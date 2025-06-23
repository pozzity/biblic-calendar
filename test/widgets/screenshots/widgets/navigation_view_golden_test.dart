// Test golden screenshots for test/widgets/screenshots/widgets/navigation_view_test.dart
import 'package:biblic_calendar/features/navigation/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../../../goldens.dart';
import '../../navigation_view_test.dart' as navigation_view_test;

void main() {
  group('Goldens', () {
    setUp(() async {
      await navigation_view_test.setupEach();
    });
    testGoldens('NavigationView', (tester) async {
      await multiScreenMultiLocaleGolden(
        tester,
        navigation_view_test.wrapWithMaterialApp(
          const NavigationView(),
          locale: AppLocalizations.supportedLocales.first,
        ),
        'navigation_view',
      );
    });
  });
}

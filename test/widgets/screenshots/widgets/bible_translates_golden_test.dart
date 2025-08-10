// Test golden screenshots for test/widgets/bible_translates_test.dart
import 'package:biblic_calendar/features/bible_translates/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../goldens.dart';
import '../../bible_translates_test.dart' as bible_translates_test;

void main() {
  group('Goldens', () {
    setUp(() async {
      // If you have setup logic, add here
    });
    testGoldens('BibleTranslatesView', (tester) async {
      await multiScreenMultiLocaleGolden(
        tester,
        bible_translates_test.wrapWithMaterialApp(
          const BibleTranslatesView(),
          locale: AppLocalizations.supportedLocales.first,
        ),
        'bible_translates_view',
      );
    });
  });
}

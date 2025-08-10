// Test golden screenshots for test/widgets/bible_reader_test.dart
import 'package:biblic_calendar/features/bible_reader/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../goldens.dart';
import '../../bible_reader_test.dart' as bible_reader_test;

void main() {
  group('Goldens', () {
    setUp(() async {
      // If you have setup logic, add here
    });
    testGoldens('BibleReaderView', (tester) async {
      await multiScreenMultiLocaleGolden(
        tester,
        bible_reader_test.wrapWithMaterialApp(
          const BibleReaderView(),
          locale: AppLocalizations.supportedLocales.first,
        ),
        'bible_reader_view',
      );
    });
  });
}

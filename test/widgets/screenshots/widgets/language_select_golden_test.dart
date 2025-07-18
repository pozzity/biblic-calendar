import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../goldens.dart';
import '../../language_select_test.dart' as language_select_test;

void main() {
  group('Goldens', () {
    setUpAll(() async {
      await language_select_test.setupAll(skipDb: true); // <-- skip DB
    });

    setUp(() async {
      await language_select_test.setupEach(skipDb: true); // <-- skip DB
    });
    testGoldens('LanguageView', (tester) async {
      await multiScreenMultiLocaleGolden(
        tester,
        language_select_test.languageWidgetWrapper(),
        'language_view',
      );
    });
  });
}

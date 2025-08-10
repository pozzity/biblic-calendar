// Test golden screenshots for test/widgets/favorite_test.dart
import 'package:biblic_calendar/features/favorite/view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import '../../favorite_test.dart' as favorite_test;

void main() {
  group('Goldens', () {
    setUp(() async {
      // If you have setup logic, add here
    });
    testGoldens('FavoriteView', (tester) async {
      await tester.pumpWidgetBuilder(
        favorite_test.wrapWithMaterialApp(const FavoriteView()),
      );
      await multiScreenGolden(tester, 'favorite_view');
    });
  });
}

import 'package:biblic_calendar/features/favorite/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:biblic_calendar/services/bible_api_service.dart';

Widget wrapWithMaterialApp(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoriteView', () {
    setUp(() {
      Get.reset();
      final api = BibleApiService();
      api.favoriteVerses.clear();
      Get.put(api);
    });

    testWidgets('shows empty state when no favorites', (tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(const FavoriteView()));
      await tester.pumpAndSettle();
      expect(find.text('No favorites yet.'), findsOneWidget);
    });
  });
}

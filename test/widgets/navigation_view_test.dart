import 'package:biblic_calendar/features/navigation/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:biblic_calendar/services/database/database.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:biblic_calendar/services/intl/intl.dart';

Widget wrapWithMaterialApp(Widget child, {Locale? locale}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: child,
  );
}

Future<void> setupEach() async {
  await Get.putAsync(IntlService.create);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NavigationView', () {
    testWidgets('displays app bar title and bottom navigation items', (
      tester,
    ) async {
      final locale = AppLocalizations.supportedLocales.first;
      final localization = await AppLocalizations.delegate.load(locale);

      await tester.pumpWidget(
        wrapWithMaterialApp(const NavigationView(), locale: locale),
      );
      await tester.pumpAndSettle();

      // AppBar title
      expect(find.text(localization.biblicalCalendar), findsOneWidget);

      // BottomNavigationBar items
      expect(find.text(localization.reader), findsOneWidget);
      expect(find.text(localization.translations), findsOneWidget);
      expect(find.text(localization.favorites), findsOneWidget);
    });

    testWidgets('switches pages when tapping bottom navigation items', (
      tester,
    ) async {
      final locale = AppLocalizations.supportedLocales.first;
      await tester.pumpWidget(
        wrapWithMaterialApp(const NavigationView(), locale: locale),
      );
      await tester.pumpAndSettle();

      // Tap on Translations tab
      await tester.tap(find.byIcon(Icons.translate));
      await tester.pumpAndSettle();

      // Tap on Favorites tab
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      // Tap on Reader tab
      await tester.tap(find.byIcon(Icons.book));
      await tester.pumpAndSettle();
    });

    testWidgets('opens right menu dialog when menu icon is tapped', (
      tester,
    ) async {
      final locale = AppLocalizations.supportedLocales.first;
      final localization = await AppLocalizations.delegate.load(locale);

      await tester.pumpWidget(
        wrapWithMaterialApp(const NavigationView(), locale: locale),
      );
      await tester.pumpAndSettle();

      // Tap menu icon
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Side menu title should be visible
      expect(find.text(localization.sideMenuTitle), findsOneWidget);

      // Dismiss dialog
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
    });
  });
}

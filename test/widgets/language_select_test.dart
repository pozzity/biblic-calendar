import 'package:biblic_calendar/entities/settings.dart';
import 'package:biblic_calendar/features/intro/controller.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:biblic_calendar/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:biblic_calendar/features/intro/widgets/language.dart';
import 'package:get/get.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:biblic_calendar/services/database/database.dart';

class MockIntlService extends IntlService {
  MockIntlService() : super.localeLang();

  @override
  Rx<Locale> get localeRx => super.localeRx;

  @override
  Locale get locale => localeRx.value;

  @override
  void updateLocale(Locale locale) {
    localeRx.value = locale;
  }
}

class MockDatabase extends GetxService implements Database {
  final _settingsBox = MockSettingsBox();

  @override
  Box<Settings> get settings => _settingsBox;
  Future<void> init() async {}
}

class MockSettingsBox implements Box<Settings> {
  final Map<int, Settings> _store = {};

  @override
  Settings? get(int id, {Settings? defaultValue}) => _store[id] ?? defaultValue;

  @override
  int put(Settings object, {PutMode mode = PutMode.insert}) {
    final id = object.id;
    object.id = id;
    _store[id] = object;
    return id;
  }

  @override
  List<Settings> getAll({int? offset, int? limit}) {
    var values = _store.values.toList();
    if (offset != null) values = values.skip(offset).toList();
    if (limit != null) values = values.take(limit).toList();
    return values;
  }

  // Implement other required members with noSuchMethod for unused ones:
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget languageWidgetWrapper() => ObxValue(
  (localeX) => MaterialApp(
    title: 'Biblical Calendar',
    supportedLocales: AppLocalizations.supportedLocales,
    locale: localeX.value,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      useMaterial3: true,
    ),
    home: Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: LanguageView(
              onSave: (locale) {
                Get.find<Preference>().updatePreferredLanguage(
                  locale.languageCode,
                );
              },
            ),
          ),
        ],
      ),
    ),
  ),
  IntlService.instance.localeRx,
);

bool skipDatabase = false;

Future<void> setupAll({bool skipDb = false}) async {
  skipDatabase = skipDb;
  if (!skipDatabase) {
    await Get.putAsync(() => Database.create(isInMemory: true));
  } else {
    Get.put<Database>(MockDatabase());
    Get.put<IntlService>(MockIntlService());
  }
  Get.put(Preference());
  Get.put(IntroController());
}

Future<void> setupEach({bool skipDb = false}) async {
  skipDatabase = skipDb;
  if (!skipDatabase) {
    await Get.putAsync(IntlService.create);
  } else {
    Get.replace<Database>(MockDatabase());
    Get.replace<IntlService>(
      MockIntlService() as dynamic,
    ); // <-- Register as dynamic
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await setupAll(skipDb: true); // Always skip DB for tests
  });

  setUp(() async {
    await setupEach(skipDb: true);
  });

  group('LanguageView', () {
    testWidgets('display properly', (WidgetTester tester) async {
      final locale = AppLocalizations.supportedLocales[0];
      final localization = await AppLocalizations.delegate.load(locale);
      Get.find<IntlService>().updateLocale(locale);
      await tester.pumpWidget(languageWidgetWrapper());
      await tester.pumpAndSettle();
      expect(find.text(localization.selectPreferredLang), findsOneWidget);
      expect(find.text(localization.language), findsOneWidget);
      expect(find.text(localization.save), findsOneWidget);
    });
    testWidgets('save properly', (WidgetTester tester) async {
      Get.find<IntlService>().updateLocale(
        AppLocalizations.supportedLocales[0],
      );
      await tester.pumpWidget(languageWidgetWrapper());
      await tester.pumpAndSettle();
      await _selectLocaleAndSave(AppLocalizations.supportedLocales[1], tester);
      expect(
        Get.find<Preference>().settings.preferredLanguage,
        AppLocalizations.supportedLocales[1].languageCode,
      );
    });
  });
}

Future<void> _selectLocaleAndSave(Locale locale, WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel(locale.languageCode));
  await tester.pumpAndSettle();
  final localization = await AppLocalizations.delegate.load(locale);
  debugPrint(
    "locale: ${locale.languageCode}; localization: ${localization.save}",
  );
  await tester.tap(find.text(localization.save));
  await tester.pumpAndSettle();
}

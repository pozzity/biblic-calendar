import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:biblic_calendar/features/intro/view.dart';
import 'package:biblic_calendar/services/preferences/preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/database/database.dart';
import 'services/intl/intl.dart';
import 'utils/functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('isTestMode: $isTestMode');

  await Get.putAsync<Database>(() {
    return Database.create(isInMemory: isTestMode || kDebugMode);
  });
  Get.putAsync<IntlService>(IntlService.create);
  Get.lazyPut<Preference>(() => Preference());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Biblical Calendar',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: IntlService.instance.localeRx.value,
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        home: const IntroView());
  }
}

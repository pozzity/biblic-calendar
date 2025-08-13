export 'navigation_view.dart';
import 'package:biblic_calendar/features/bible_reader/view.dart';
import 'package:biblic_calendar/features/bible_translates/view.dart';
import 'package:biblic_calendar/features/favorite/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:biblic_calendar/services/bible_api_service.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int _selectedIndex =
      1; // Start with BibleTranslatesView as the first focused page
  final BibleApiService api = Get.put(BibleApiService());

  final List<Widget> _pages = [
    BibleReaderView() as Widget,
    BibleTranslatesView() as Widget,
    FavoriteView() as Widget,
  ];

  void _onItemTapped(int index) {
    if (api.defaultVersionId.value == null && index != 1) {
      // Only allow access to BibleTranslatesView if no default version
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a default Bible version first.')),
      );
      setState(() => _selectedIndex = 1);
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openRightMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Material(
              color: Theme.of(context).canvasColor,
              child: SafeArea(
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.sideMenuTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 24),
                      _buildLanguageSwitcher(context),
                      // ...add more menu items here...
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  Widget _buildLanguageSwitcher(BuildContext context) {
    final supported = AppLocalizations.supportedLocales;
    final current = IntlService.instance.localeRx.value;
    final normalized = supported.firstWhere(
      (l) => l.languageCode == current.languageCode,
      orElse: () => supported.first,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppLocalizations.of(context)!.language, style: Styles.i.tsHeader1),
        DropdownButton<Locale>(
          value: normalized,
          items: supported.map((locale) {
            return DropdownMenuItem(
              value: locale,
              child: Text(
                locale.languageCode == 'en'
                    ? AppLocalizations.of(context)!.en
                    : AppLocalizations.of(context)!.fr,
              ),
            );
          }).toList(),
          onChanged: (locale) {
            if (locale != null) {
              IntlService.instance.updateLocale(locale);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.biblicalCalendar),
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: _openRightMenu),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Obx(() {
        final disabled = api.defaultVersionId.value == null;
        return BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.book, color: disabled ? Colors.grey : null),
              label: AppLocalizations.of(context)!.reader,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.translate),
              label: AppLocalizations.of(context)!.translations,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: disabled ? Colors.grey : null),
              label: AppLocalizations.of(context)!.favorites,
            ),
          ],
        );
      }),
    );
  }
}

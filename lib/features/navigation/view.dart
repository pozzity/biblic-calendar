import 'package:biblic_calendar/features/bible_reader/view.dart';
import 'package:biblic_calendar/features/bible_translates/view.dart';
import 'package:biblic_calendar/features/favorite/view.dart';
import 'package:biblic_calendar/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BibleReaderView(),
    BibleTranslatesView(),
    FavoriteView(),
  ];

  void _onItemTapped(int index) {
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
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.sideMenuTitle),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: AppLocalizations.of(context)!.reader,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: AppLocalizations.of(context)!.translations,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.favorites,
          ),
        ],
      ),
    );
  }
}

import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:flutter/material.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class FirstStepPage extends StatefulWidget {
  @override
  _FirstStepPageState createState() => _FirstStepPageState();
}

class _FirstStepPageState extends State<FirstStepPage> {
  final _FirstStepPageData that;

  _FirstStepPageState() : that = _FirstStepPageData() {
    that.view = this;
  }

  String? _btText;
  bool isEnd = false;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    _btText = isEnd ? IntlService.instance.start : S.of(context).ignore;

    if (that.viewState == 0)
      return Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: SingleChildScrollView(
                    child: SizedBox(
                        height: screen.height > 390 ? screen.height - 30 : 360,
                        child: showPageView()))),
            if (that.langSelected == null || that.langSelected.length == 0)
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: LanguageView(
                    onSave: (ctx, lang) {
                      setState(() {
                        that.langSelected = lang;
                      });
                    },
                  )),
          ],
        ),
      ));
    if (that.viewState == 1)
      return BibleTranslatesPage(afterDownload: (_) async {
        (await fn.pref).setBool(fn.KEY.firstLoad, false);
        goToHome();
      });
    return Scaffold(body: Container());
  }

  void update() => setState(() {});

  Widget showPageView() {
    final displays = tabDisplays();
    return DefaultTabController(
        length: 3,
        child: Builder(builder: (BuildContext context) {
          final defaultCtrl = DefaultTabController.of(context);
          defaultCtrl.addListener(() {
            if (defaultCtrl.index == displays.length - 1 && !isEnd)
              return setState(() => isEnd = true);
            if (defaultCtrl.index != displays.length - 1 && isEnd)
              return setState(() => isEnd = false);
          });
          return Column(children: <Widget>[
            Expanded(child: TabBarView(children: displays)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TabPageSelector(),
                  RaisedButton(
                      color: Colors.brown,
                      child: Text(
                        _btText,
                        style: TextStyle(color: Colors.white70),
                      ),
                      onPressed: () {
                        final TabController ctrl =
                            DefaultTabController.of(context);
                        if (ctrl.index == displays.length - 1)
                          setState(() {
                            that.viewState = 1;
                          });

                        if (!ctrl.indexIsChanging) {
                          ctrl.animateTo(displays.length - 1);
                        }
                      })
                ])
          ]);
        }));
  }

  List<Widget> tabDisplays() {
    final welcome = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Text(
            S.of(context).module_welcome_header,
            style: fn.style.tsHeader2,
          ),
        ),
        Text(
          S.of(context).module_welcome_content,
          style: fn.style.tsHeader1,
        )
      ],
    );
    final moduleBile = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Text(
            S.of(context).module_bible_header,
            style: fn.style.tsHeader2,
          ),
        ),
        Text(
          S.of(context).module_bible_content,
          style: fn.style.tsHeader1,
        )
      ],
    );
    final moduleCalendar = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Text(
            S.of(context).module_calendar_header,
            style: fn.style.tsHeader2,
          ),
        ),
        Text(
          S.of(context).module_calendar_content,
          style: fn.style.tsHeader1,
        )
      ],
    );
    p(Widget wg) => Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: wg,
        );
    return <Widget>[p(welcome), p(moduleBile), p(moduleCalendar)];
  }

  void goToHome() => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
}

class _FirstStepPageData {
  _FirstStepPageState view;

  /// retourne contient l'etat de l'application
  /// 0: affichage des slides
  /// 1: affichage des bible a telecharger
  /// autre: chargement
  int viewState;

  String langSelected;

  _FirstStepPageData() {
    ready();
  }

  void ready() async {
    final res = (await fn.pref).getBool(fn.KEY.firstLoad);
    langSelected = (await fn.pref).getString(fn.KEY.lang);
    fn.currentLang = langSelected ?? "en";
    S.load(Locale(langSelected ?? "en"));
    if (res != false) {
      viewState = 0;
    } else {
      view?.goToHome();
    }
    view?.update();
  }
}

import 'package:biblic_calendar/features/intro/widgets/language.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(IntroController());
    return const _FirstStepPage();
  }
}

class _FirstStepPage extends GetView<IntroController> {
  const _FirstStepPage();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

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
          if (!controller.hasSelectedLanguage.value)
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: LanguageView(
                  onSave: (locale) {
                    controller.hasSelectedLanguage.value = true;
                    controller.pref
                        .updatePreferredLanguage(locale.toHashString());
                  },
                )),
        ],
      ),
    ));
  }

  Widget showPageView() {
    final displays = tabDisplays();
    return DefaultTabController(
        length: displays.length,
        child: Builder(builder: (BuildContext context) {
          final defaultCtrl = DefaultTabController.of(context);
          defaultCtrl.addListener(() {
            if (defaultCtrl.index == displays.length - 1 &&
                !controller.isEnd.value) {
              controller.isEnd.value = true;
              return;
            }
            if (defaultCtrl.index != displays.length - 1 &&
                controller.isEnd.value) {
              controller.isEnd.value = false;
              return;
            }
          });
          return Column(children: <Widget>[
            Expanded(child: TabBarView(children: displays)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TabPageSelector(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                      ),
                      child: Obx(() => Text(
                            controller.btText,
                            style: TextStyle(color: Colors.white70),
                          )),
                      onPressed: () {
                        final TabController ctrl =
                            DefaultTabController.of(context);
                        if (ctrl.index == displays.length - 1) {
                          controller.hasSelectedLanguage.value = true;
                        }

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
            IntlService.instance.moduleWelcomeHeader,
            style: Styles.i.tsHeader2,
          ),
        ),
        Text(
          IntlService.instance.moduleWelcomeContent,
          style: Styles.i.tsHeader1,
        )
      ],
    );
    final moduleBile = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Text(
            IntlService.instance.moduleBibleHeader,
            style: Styles.i.tsHeader2,
          ),
        ),
        Text(
          IntlService.instance.moduleBibleContent,
          style: Styles.i.tsHeader1,
        )
      ],
    );
    final moduleCalendar = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Text(
            IntlService.instance.moduleCalendarHeader,
            style: Styles.i.tsHeader2,
          ),
        ),
        Text(
          IntlService.instance.moduleCalendarContent,
          style: Styles.i.tsHeader1,
        )
      ],
    );
    p(Widget wg) => Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: wg,
        );
    return <Widget>[p(welcome), p(moduleBile), p(moduleCalendar)];
  }
}

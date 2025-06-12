import 'package:biblic_calendar/features/intro/controller.dart';
import 'package:biblic_calendar/services/intl/intl.dart';
import 'package:biblic_calendar/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LanguageView extends GetView<IntroController> {
  final void Function(Locale locale) onSave;

  const LanguageView({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return ObxValue(
      (selectedLocale) => Container(
        color: Colors.brown.shade50,
        child: SingleChildScrollView(
          child: SizedBox(
            height: screen.height > 390 ? screen.height - 30 : 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                    child: Text(
                      IntlService.instance.selectPreferredLang,
                      textAlign: TextAlign.center,
                      style: Styles.i.tsHeader2,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 135,
                      width: 250,
                      child: DecoratedBox(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color:
                                  Colors.brown.shade300.withValues(alpha: .5),
                              blurRadius: 50,
                              spreadRadius: 10)
                        ]),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.brown.withValues(alpha: 0.5)),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      IntlService.instance.language,
                                      textAlign: TextAlign.left,
                                      style: Styles.i.tsHeader1
                                          .withValues(color: Colors.white),
                                    ),
                                    Text(
                                      selectedLocale.value.languageCode == "fr"
                                          ? IntlService.instance.french
                                          : IntlService.instance.english,
                                      style: Styles.i.tsBody1.withValues(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ...IntlService.supportedLocales
                                .map((locale) => InkWell(
                                      onTap: () async {
                                        selectedLocale.value = locale;
                                        IntlService.instance
                                            .updateLocale(locale);
                                      },
                                      child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: selectedLocale
                                                          .value.languageCode ==
                                                      locale.languageCode
                                                  ? Colors.brown.shade200
                                                      .withValues(alpha: 0.5)
                                                  : Colors.brown.shade300
                                                      .withValues(alpha: 0.7)),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                              locale.languageCode == "en"
                                                  ? IntlService.instance.english
                                                  : IntlService.instance.french,
                                              style: Styles.i.tsBody1
                                                  .withValues(
                                                      color: Colors.white))),
                                    ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            onSave(selectedLocale.value);
                          },
                          icon: Icon(
                            Icons.language,
                            color: Colors.brown,
                          ),
                          label: Text(
                            IntlService.instance.save,
                            style: Styles.i.tsHeader,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      IntlService.instance.locale.obs,
    );
  }
}

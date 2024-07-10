import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_application_1/presentation/appbar.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<String>> questions = [
      [
        AppLocalizations.of(context)!.faqQuestionOne,
        AppLocalizations.of(context)!.faqAnswerOne
      ],
      [
        AppLocalizations.of(context)!.faqQuestionTwo,
        AppLocalizations.of(context)!.faqAnswerTwo
      ],
      [
        AppLocalizations.of(context)!.faqQuestionThree,
        AppLocalizations.of(context)!.faqAnswerThree
      ],
      [
        AppLocalizations.of(context)!.faqQuestionFour,
        AppLocalizations.of(context)!.faqAnswerFour
      ],
    ];
    return Scaffold(
      appBar: AppBarDesign().noDrawerAppBar(),
      body: Column(
        children: [
          Container(
            width: 800,
            height: 50,
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.faq,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gill')),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(questions[index][0]),
                    subtitle: Text(questions[index][1]),
                  );
                }),
          )
        ],
      ),
    );
  }
}

//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SatisfactionSurvey extends StatefulWidget {
  const SatisfactionSurvey({Key? key}) : super(key: key);

  @override
  State<SatisfactionSurvey> createState() => _SatisfactionSurveyState();
}

// List<String> closeEndedQuestions = [
//   'Q1: How would you rate your initial experience with navigating the app\'s interface?',
//   'Q2: How confident do you feel in your ability to utilize the app\'s features effectively?',
//   'Q3: Overall, how satisfied are you with the app\'s performance and responsiveness?',
//   'Q4: To what extent do you find the app\'s functionalities intuitive and easy to understand?',
//   'Q5: How likely are you to recommend this app to others based on your experience?'
// ];

List<String> closeEndedQuestions(BuildContext context) {
  return [
    AppLocalizations.of(context)!.q_one,
    AppLocalizations.of(context)!.q_two,
    AppLocalizations.of(context)!.q_three,
    AppLocalizations.of(context)!.q_four,
    AppLocalizations.of(context)!.q_five,
  ];
}

String openEndedQuestion =
    'Could you please share any specific challenges you faced or standout features you appreciated while using the app?';

// List<List<String>> scales = [
//   [
//     'Quite confusing',
//     'A bit challenging',
//     'Fairly intuitive',
//     'Extremely user-friendly'
//   ],
//   [
//     'Not very confident',
//     'Somewhat confident',
//     'Moderately confident',
//     'Very confident'
//   ],
//   [
//     'Very dissatisfied',
//     'Somewhat dissatisfied',
//     'Fairly satisfied',
//     'Extremely satisfied'
//   ],
//   [
//     'Not intuitive at all',
//     'Somewhat intuitive',
//     'Quite intuitive',
//     'Very intuitive'
//   ],
//   ['Not likely at all', 'Somewhat likely', 'Quite likely', 'Very likely']
// ];

List<List<String>> scales(BuildContext context) {
  return [
    [
      AppLocalizations.of(context)!.quite_confusing,
      AppLocalizations.of(context)!.a_bit_challenging,
      AppLocalizations.of(context)!.fairly_intuitive,
      AppLocalizations.of(context)!.extremely_user_friendly
    ],
    [
      AppLocalizations.of(context)!.not_very_confident,
      AppLocalizations.of(context)!.somewhat_confident,
      AppLocalizations.of(context)!.moderately_confident,
      AppLocalizations.of(context)!.very_confident
    ],
    [
      AppLocalizations.of(context)!.very_dissatisfied,
      AppLocalizations.of(context)!.somewhat_dissatisfied,
      AppLocalizations.of(context)!.fairly_satisfied,
      AppLocalizations.of(context)!.extremely_satisfied
    ],
    [
      AppLocalizations.of(context)!.not_intuitive_at_all,
      AppLocalizations.of(context)!.somewhat_intuitive,
      AppLocalizations.of(context)!.quite_intuitive,
      AppLocalizations.of(context)!.very_intuitive
    ],
    [
      AppLocalizations.of(context)!.not_likely_at_all,
      AppLocalizations.of(context)!.somewhat_likely,
      AppLocalizations.of(context)!.quite_likely,
      AppLocalizations.of(context)!.very_likely
    ]
  ];
}

TextEditingController commentsController = TextEditingController();

class _SatisfactionSurveyState extends State<SatisfactionSurvey> {
  Future<void> submitSurvey(int q_one, int q_two, int q_three, int q_four,
      int q_five, String comments) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final response =
        await http.post(Uri.parse('${GlobalVariables().survey}'), body: {
      'q_one': '$q_one',
      'q_two': '$q_two',
      'q_three': '$q_three',
      'q_four': '$q_four',
      'q_five': '$q_five',
      'comments': "$comments",
      'submission_datetime': '$formattedDate'
    });

    //Map<String, dynamic> feedback = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Map<String, dynamic> feedback = jsonDecode(response.body);
      // String feedbackComments = feedback['q_one'];
      //debugPrint('${response.body} ------- FEEDBACK RESPONSE');
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
            content: Text(
                AppLocalizations.of(context)!.survey_submitted_successfully),
          ),
        );
        //Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        });
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.survey_submitted_failed),
          ),
        );
      });
    }
  }

  // List<String> questions = closeEndedQuestions(context);
  // List<List<String>> scalesList = scales(context);
  // List<int?> identityValue = List.filled(questions.length, 1);
  late List<String> questions;
  late List<List<String>> scalesList;
  late List<int?> identityValue;

  @override
  void initState() {
    super.initState();
    // questions = closeEndedQuestions(context);
    // scalesList = scales(context);
    // identityValue = List.filled(questions.length, 1);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    questions = closeEndedQuestions(context);
    scalesList = scales(context);
    identityValue = List.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    //List<int?> identityValue = List.filled(scalesList.length, null);
    return Scaffold(
      appBar: AppBarDesign().noDrawerAppBar(),
      body: Column(
        children: [
          Container(
            width: 800,
            height: 50,
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                AppLocalizations.of(context)!.satisfaction_survey,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gill',
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(questions[index]),
                      ),
                      Column(
                        children: scalesList[index]
                            .map((scale) => RadioListTile(
                                  title: Text(scale),
                                  value: scalesList[index].indexOf(scale),
                                  groupValue: identityValue[index],
                                  onChanged: (value) {
                                    setState(() {
                                      identityValue[index] = value!;
                                      debugPrint(
                                          '${scalesList[index].indexOf(scale)} -- ${identityValue[index]} -- $value > RB Val ${scalesList[index]}');
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: commentsController,
              maxLength: 255,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hoverColor: Colors.green,
                labelText: AppLocalizations.of(context)!.comments,
                labelStyle: TextStyle(color: Colors.grey),
                focusColor: Colors.green,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () async {
                //debugPrint('Submit');
                bool anyUnanswered = false;
                for (int? value in identityValue) {
                  if (value == null) {
                    anyUnanswered = true;
                    break;
                  }
                }
                if (anyUnanswered) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please answer all questions.'),
                    ),
                  );
                } else {
                  int q_one = identityValue[0] ?? -1; // Default value if null
                  int q_two = identityValue[1] ?? -1;
                  int q_three = identityValue[2] ?? -1;
                  int q_four = identityValue[3] ?? -1;
                  int q_five = identityValue[4] ?? -1;
                  String comments = commentsController.value.text;

                  await submitSurvey(
                      q_one, q_two, q_three, q_four, q_five, comments);
                }
              },
              child: Text(AppLocalizations.of(context)!.submitButton),
            ),
          ),
        ],
      ),
    );
  }
}

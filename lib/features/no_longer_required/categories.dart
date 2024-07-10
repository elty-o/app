import 'package:flutter/material.dart';

// import 'package:flutter_application_1/features/eservices/consumer_protection.dart';
// import 'package:flutter_application_1/features/eservices/education.dart';
// import 'package:flutter_application_1/features/eservices/environment.dart';
import 'package:flutter_application_1/features/eservices/health.dart';
// import 'package:flutter_application_1/services/text_service.dart';
// import 'package:flutter_application_1/services/translator_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  //String pageTitle = TextService.categoriesPageTitle;
  //Map<String, String> eservices = TextService.eservices;
  //bool isTextTranslated = false;

  @override
  void initState() {
    //toChangeText();
    super.initState();
  }

  // void toChangeText() async {
  //   final translatedData =
  //       await TranslationService.translate(TextService.categoriesTextFields);
  //   setState(() {
  //     pageTitle = translatedData['pageTitle'] ?? '';
  //     eservices = Map<String, String>.from(translatedData['eservices'] ?? {});
  //     isTextTranslated = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Map<String, String> eservices = {
    //   "service_1": "BIRTH & PARENTING",
    //   "service_2": "ENVIRONMENT",
    //   "service_3": "AGRICULTURE & LAND",
    //   "service_4": "HEALTH",
    //   "service_5": "CONSUMER PROTECTION",
    //   "service_6": "EDUCATION",
    // };
    Map<String, String> eservices = {
      "service_1": AppLocalizations.of(context)!.service_one,
      "service_2": AppLocalizations.of(context)!.service_two,
      "service_3": AppLocalizations.of(context)!.service_three,
      "service_4": AppLocalizations.of(context)!.service_four,
      "service_5": AppLocalizations.of(context)!.service_five,
      "service_6": AppLocalizations.of(context)!.service_six,
    };
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.categories_title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gill'),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Column(
                    children: [
                      // FIRST ROW
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/BirthParrenting.png')),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      eservices['service_1'] ?? '',
                                      style: TextStyle(
                                          fontFamily: 'Gill',
                                          color: Colors.green,
                                          fontSize: 12),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             Environment()));
                                  },
                                  child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/Environment.png')),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          eservices['service_2'] ?? '',
                                          style: TextStyle(
                                              fontFamily: 'Gill',
                                              color: Colors.green,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      // SECOND ROW
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/AgricultureLand.png')),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        eservices['service_3'] ?? '',
                                        style: TextStyle(
                                            fontFamily: 'Gill',
                                            color: Colors.green,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Health()));
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/Health.png')),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          eservices['service_4'] ?? '',
                                          style: TextStyle(
                                              fontFamily: 'Gill',
                                              color: Colors.green,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Third Row
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const ConsumerProtection()));
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Image(
                                            image: AssetImage(
                                                'assets/ConsumerProtection.png')),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        eservices['service_5'] ?? '',
                                        style: TextStyle(
                                            fontFamily: 'Gill',
                                            color: Colors.green,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const Education()));
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/Education.png')),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          eservices['service_6'] ?? '',
                                          style: TextStyle(
                                              fontFamily: 'Gill',
                                              color: Colors.green,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
              // : Expanded(
              //     child: Center(
              //         child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Padding(
              //           padding: EdgeInsets.all(40),
              //           child: Image(
              //             image: AssetImage('assets/appbar/appbar.png'),
              //           ),
              //         ),
              //         CircularProgressIndicator(),
              //       ],
              //     )),
              //   ),
              ),
        ),
      ),
    );
  }
}

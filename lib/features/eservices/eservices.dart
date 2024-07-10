import 'package:flutter/material.dart';
//import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class EServices extends StatefulWidget {
  const EServices({super.key});

  @override
  State<EServices> createState() => _EServicesState();
}

class _EServicesState extends State<EServices> {
  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> eservices_titles = [
      [AppLocalizations.of(context)!.service_one, 'assets/BirthParrenting.png'],
      [AppLocalizations.of(context)!.service_two, 'assets/Environment.png'],
      [
        AppLocalizations.of(context)!.service_three,
        'assets/AgricultureLand.png'
      ],
      [AppLocalizations.of(context)!.service_four, 'assets/Health.png'],
      [
        AppLocalizations.of(context)!.service_five,
        'assets/ConsumerProtection.png'
      ],
      [AppLocalizations.of(context)!.service_six, 'assets/Education.png'],
      [
        AppLocalizations.of(context)!.employmentAndLabour,
        'assets/EmploymentLabour.png'
      ],
      // ['Sport, Arts and Culture', 'assets/ArtsCultureSport.png']
    ];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.categories,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gill'),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: eservices_titles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/services', arguments: {
                        'header': eservices_titles[index][0],
                        'index': index
                      });
                    },
                    child: Card(
                      elevation: 0,
                      child: Stack(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    eservices_titles[index][1],
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  eservices_titles[index][0],
                                  style: TextStyle(
                                      fontFamily: 'Gill',
                                      color: Colors.green,
                                      fontSize: 12),
                                  textAlign: TextAlign.center,
                                )
                              ]),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

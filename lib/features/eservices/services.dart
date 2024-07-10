import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:flutter_application_1/core/login_modal.dart';
import 'package:flutter_application_1/entities/favorite_helper.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  String jwt = GlobalVariables().token;
  List<List<dynamic>> birthingAndParenting = [];
  List<List<dynamic>> environmentSubAudience = [];
  List<List<dynamic>> agricultureSubAudience = [];
  List<List<dynamic>> healthSubAudience = [];
  List<List<dynamic>> consumerSubAudience = [];
  List<List<dynamic>> educationSubAudience = [];
  List<List<dynamic>> employmentAndLabourSubAudience = [];

  List<bool> favoriteStatus = [];
  List<bool> environmentStatus = [];
  List<bool> agricultureStatus = [];
  List<bool> healthStatus = [];
  List<bool> consumerStatus = [];
  List<bool> educationStatus = [];
  List<bool> employmentAndLabourStatus = [];

  @override
  void initState() {
    super.initState();
    favoriteStatus = List.filled(0, false);
    environmentStatus = List.filled(0, false);
    agricultureStatus = List.filled(0, false);
    healthStatus = List.filled(0, false);
    consumerStatus = List.filled(0, false);
    educationStatus = List.filled(0, false);
    employmentAndLabourStatus = List.filled(0, false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeLists();
  }

  void _initializeLists() {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    setState(() {
      birthingAndParenting = [
        [localizations.prenatal_care, '${GlobalVariables().urlPrenatalCare}'],
        [localizations.paternity_test, '${GlobalVariables().urlPaternityTest}'],
        [
          localizations.child_immunisation,
          '${GlobalVariables().urlChildImmunization}'
        ]
      ];

      environmentSubAudience = [
        [
          localizations.department_of_forestry_fisheries_and_the_environment,
          '${GlobalVariables().urlDFFE}'
        ],
        [localizations.kZneLicense, '${GlobalVariables().urlKZNPermit}'],
        [localizations.fsEpermit, '${GlobalVariables().urlFSEPermit}'],
        [localizations.ecEpermit, '${GlobalVariables().urlECPermit}'],
        [localizations.limpopoEpermit, '${GlobalVariables().urlLimpopoPermit}']
      ];

      agricultureSubAudience = [
        [localizations.land_services, '${GlobalVariables().urlLandServices}'],
        // [
        //   'Agro Industry',
        //   'https://beta.eservices.gov.za/AIMIP/Account/Login?id='
        // ]
      ];

      healthSubAudience = [
        [
          localizations.free_state_school_of_nursing,
          '${GlobalVariables().urlFSON}'
        ],
        [
          localizations.henrietta_stockdale_nursing_college,
          '${GlobalVariables().urlHSN}'
        ],
        [localizations.rehab, '${GlobalVariables().urlRehab}']
      ];

      consumerSubAudience = [
        [
          localizations.sita_complaints,
          '${GlobalVariables().urlSITAComplaint}'
        ],
        [localizations.fsEcomplaint, '${GlobalVariables().urlFSEcomplaints}']
      ];

      educationSubAudience = [
        [localizations.dhet_exam_queries, '${GlobalVariables().urlDhet}'],
        [
          localizations.free_state_school_of_nursing,
          '${GlobalVariables().urlFSON}'
        ],
        [localizations.ltsm, '${GlobalVariables().urlLTSM}'],
        // [localizations.nols, '${GlobalVariables().urlNols}'],
        // [
        //   'Funza Lushaka Bursary',
        //   'http://beta.eservices.gov.za/FunzaLushaka/OTP/Index?id='
        // ],
        // [
        //   'Funza Lushaka Bursary Backend',
        //   'http://beta.eservices.gov.za/FunzaLushakaBackEnd/OTP/Index?id='
        // ],
        // [
        //   'Henrietta Stockdale Nursing College',
        //   'https://beta.eservices.gov.za/hsnc/eregister?id='
        // ],
        // ['Re-Issue', 'http://beta.eservices.gov.za/e-Re-Issue/ReIssue?id='],
        // [
        //   'Re-Mark/Re-Check',
        //   'https://beta.eservices.gov.za/e-Recheck/Recheck?id='
        // ],
        // [
        //   'TVET Colleges Mashzone Dashboards',
        //   'http://beta.eservices.gov.za/mashzone?id='
        // ],
        // [
        //   'SACE Professional Registration',
        //   'http://beta.eservices.gov.za/SACE/Account/Login/?id='
        // ],
      ];

      employmentAndLabourSubAudience = [
        [
          localizations.sitaRecruitment,
          '${GlobalVariables().urlSitaRecruitment}'
        ],
        [localizations.pea, '${GlobalVariables().urlPEA}'],
      ];

      favoriteStatus = List.filled(birthingAndParenting.length, false);
      environmentStatus = List.filled(environmentSubAudience.length, false);
      agricultureStatus = List.filled(agricultureSubAudience.length, false);
      healthStatus = List.filled(healthSubAudience.length, false);
      consumerStatus = List.filled(consumerSubAudience.length, false);
      educationStatus = List.filled(educationSubAudience.length, false);
      employmentAndLabourStatus =
          List.filled(employmentAndLabourSubAudience.length, false);

      _initializeFavoriteStatus();
    });
  }

  Future<void> _initializeFavoriteStatus() async {
    final itemsWithTrueIndicator =
        await FavoriteHelper.getItemsWithTrueIndicator();
    setState(() {
      for (var item in itemsWithTrueIndicator) {
        int index = birthingAndParenting
            .indexWhere((element) => element[0] == item['name']);
        if (index != -1) {
          favoriteStatus[index] = true;
        }
        int envIndex = environmentSubAudience
            .indexWhere((element) => element[0] == item['name']);
        if (envIndex != -1) {
          environmentStatus[envIndex] = true;
        }
        int agrIndex = agricultureSubAudience
            .indexWhere((element) => element[0] == item['name']);
        if (agrIndex != -1) {
          agricultureStatus[agrIndex] = true;
        }
        int healthIndex = healthSubAudience
            .indexWhere((element) => element[0] == item['name']);
        if (healthIndex != -1) {
          healthStatus[healthIndex] = true;
        }
        int consumerIndex = consumerSubAudience
            .indexWhere((element) => element[0] == item['name']);
        if (consumerIndex != -1) {
          consumerStatus[consumerIndex] = true;
        }
        int educationIndex = educationSubAudience
            .indexWhere((element) => element[0] == item['name']);
        if (educationIndex != -1) {
          educationStatus[educationIndex] = true;
        }
        int employmentAndLabourIndex = employmentAndLabourSubAudience
            .indexWhere((element) => element[0] == item['name']);
        if (employmentAndLabourIndex != -1) {
          employmentAndLabourStatus[employmentAndLabourIndex] = true;
        }
      }
    });
  }

  Future<void> addFavorite(String name, String url, String indicator) async {
    debugPrint('This is the status $name');
    await FavoriteHelper.createItem(name, url, indicator);
  }

  Future<void> deleteFavorite(String name) async {
    await FavoriteHelper.deleteItemByName(name);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String header = args['header'];
    int modalIndex = args['index'];
    int itemCount = 0;
    List<List<dynamic>> currentList = [];
    List<bool> currentStatus = [];
    debugPrint('THIS IS MODAL INDEX: $modalIndex');
    switch (modalIndex) {
      case 0:
        currentList = birthingAndParenting;
        currentStatus = favoriteStatus;
        itemCount = birthingAndParenting.length;
        break;
      case 1:
        currentList = environmentSubAudience;
        currentStatus = environmentStatus;
        itemCount = environmentSubAudience.length;
        break;
      case 2:
        currentList = agricultureSubAudience;
        currentStatus = agricultureStatus;
        itemCount = agricultureSubAudience.length;
        break;
      case 3:
        currentList = healthSubAudience;
        currentStatus = healthStatus;
        itemCount = healthSubAudience.length;
        break;
      case 4:
        currentList = consumerSubAudience;
        currentStatus = consumerStatus;
        itemCount = consumerSubAudience.length;
        break;
      case 5:
        currentList = educationSubAudience;
        currentStatus = educationStatus;
        itemCount = educationSubAudience.length;
        break;
      case 6:
        currentList = employmentAndLabourSubAudience;
        currentStatus = employmentAndLabourStatus;
        itemCount = employmentAndLabourSubAudience.length;
        break;
      default:
        itemCount = 0;
    }

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
              child: Text(header,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gill')),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        if (GlobalVariables().loggedIn) {
                          if (modalIndex == 0) {
                            Navigator.pushNamed(context, '/webpage',
                                arguments: {
                                  'url': '${currentList[index][1]}',
                                  'name': currentList[index][0]
                                });
                          } else {
                            Navigator.pushNamed(context, '/webpage',
                                arguments: {
                                  'url': '${currentList[index][1]}$jwt',
                                  'name': currentList[index][0]
                                });
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              GlobalVariables().globalUrl =
                                  currentList[index][1];
                              return LoginModal();
                            },
                          );
                        }
                      },
                      title: Text(currentList[index][0]),
                      trailing: IconButton(
                        icon: Icon(
                          currentStatus[index]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          setState(() {
                            currentStatus[index] = !currentStatus[index];
                            if (currentStatus[index]) {
                              addFavorite(
                                currentList[index][0],
                                currentList[index][1],
                                currentStatus[index].toString(),
                              );
                            } else {
                              deleteFavorite(currentList[index][0]);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

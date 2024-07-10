import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:flutter_application_1/presentation/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_application_1/core/login_modal.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {
  //int checkBody = 0;
  String serverName = GlobalVariables.server;
  String jwt = GlobalVariables().token;
  String freeStateUrl = '${GlobalVariables.server}/fs-son/epermit?id=';
  String hsncUrl = '${GlobalVariables.server}/hsnc/eregister?id=';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarDesign().secondaryAppBar(),
        endDrawer: DrawerDesign().mainDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 800,
                height: 50,
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.health,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gill')),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: () {
                            if (GlobalVariables().loggedIn) {
                              Navigator.pushNamed(context, '/webpage',
                                  arguments: {
                                    'url': '$freeStateUrl$jwt',
                                    //'https://www.eservices.gov.za/fs-son/epermit?id=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlbHRvbi5vbGl2ZXJAc2l0YS5jby56YSJ9.Cee4pK7FQQ-kXxjV6amoqU9D3s6X6dgjdgvn0X5ICnc',
                                    'name': AppLocalizations.of(context)!
                                        .fs_school_of_nursing
                                  });
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  GlobalVariables().globalUrl = '$freeStateUrl';
                                  return LoginModal();
                                },
                              );
                            }
                          },
                          title: Text(
                            AppLocalizations.of(context)!
                                .free_state_school_of_nursing,
                            style: TextStyle(
                              fontFamily: 'Gill',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: () {
                            if (GlobalVariables().loggedIn) {
                              Navigator.pushNamed(context, '/webpage',
                                  arguments: {
                                    'url': '$hsncUrl$jwt',
                                    //'https://www.eservices.gov.za/hsnc/eregister?id=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlbHRvbi5vbGl2ZXJAc2l0YS5jby56YSJ9.Cee4pK7FQQ-kXxjV6amoqU9D3s6X6dgjdgvn0X5ICnc',
                                    'name': 'Henrietta Stockdale'
                                  });
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  GlobalVariables().globalUrl = '$hsncUrl';
                                  return LoginModal();
                                },
                              );
                            }
                          },
                          title: Text(
                            AppLocalizations.of(context)!
                                .henrietta_stockdale_nursing_college,
                            style: TextStyle(
                              fontFamily: 'Gill',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

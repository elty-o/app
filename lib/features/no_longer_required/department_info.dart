import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/features/use_case_1/login.dart';
import 'package:flutter_application_1/features/use_case_2/notifications.dart';
//import 'package:flutter_application_1/core/globals.dart';

class DepartmentInfo extends StatefulWidget {
  const DepartmentInfo({super.key});

  @override
  State<DepartmentInfo> createState() => _DepartmentInfoState();
}

class _DepartmentInfoState extends State<DepartmentInfo> {
  int checkBody = 0;
  String serverName =
      GlobalVariables.server; //;'https://beta.eservices.gov.za';
  String jwt =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqb2huLm1vaGFsYW5lQHNpdGEuY28uemEifQ.7YQKWoNo0ZQIb9Mn5igd1wX07hKJcGpqDm9oYTR25MM';

  //String serverName = 'http://192.168.8.100';
  Future<List<Map<String, dynamic>>> fetchDataFromSubAudience(String id) async {
    final response = await http.post(
        Uri.parse('$serverName/tnk/subaudience.php'),
        body: {'audienceId': id});

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> jsonDataList =
          (json.decode(response.body) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      return jsonDataList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchDataFromServiceAndAudience(
      String id) async {
    final response = await http.post(
        Uri.parse('$serverName/tnk/serviceaudience.php'),
        body: {'id': id});

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> jsonDataList =
          (json.decode(response.body) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      return jsonDataList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //This is for all the e-Services
  Future<List<Map<String, dynamic>>> fetchDataFromServices(String id) async {
    final response = await http
        .post(Uri.parse('$serverName/tnk/services.php'), body: {'id': id});

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> jsonDataList =
          (json.decode(response.body) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      return jsonDataList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildMoreInfo(String value) {
    List<String> moreInfo = [];

    return moreInfo.isNotEmpty
        ? ListView.builder(
            itemCount: moreInfo.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                collapsedBackgroundColor: Colors.grey[200],
                title: ListTile(
                  title: Text(moreInfo[index]),
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(title: Text('Just Text')),
                  ),
                ],
              );
            })
        : const Center(
            child: Text(
              'More information not available yet...',
              style: TextStyle(color: Colors.grey),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String department = args['department'];
    final String id = args['id'];
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Image(
                height: 30,
                image: AssetImage('assets/appbar/appbar.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Image(
                height: 30,
                image: AssetImage('assets/appbar/ndp.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Image(
                height: 30,
                image: AssetImage('assets/appbar/saflag.png'),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Notifications()));
                },
                icon: const Icon(Icons.phone_in_talk_rounded)),
            IconButton(
              icon: const Icon(
                Icons.account_box_rounded,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 800,
                height: 50,
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(department,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gill')),
                ),
              ),
              SizedBox(
                height: 800,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchDataFromSubAudience(id),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Error fetching data from Sub-Audience: ${snapshot.error}'),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          // FutureBuilder(
                          //     future: fetchDataFromServices(id),
                          //     builder: (context, AsyncSnapshot subsnapshot) {
                          //       if (subsnapshot.connectionState ==
                          //           ConnectionState.waiting) {
                          //         return const Center(
                          //           child: CircularProgressIndicator(),
                          //         );
                          //       } else if (subsnapshot.hasError) {
                          //         return Center(
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //                 'Error fetching data from Services: ${subsnapshot.error}'),
                          //           ),
                          //         );
                          //       } else if (subsnapshot.data.length <= 0) {
                          //         return Container();
                          //         // return const Center(
                          //         //   child: Padding(
                          //         //     padding: EdgeInsets.all(8.0),
                          //         //     child: Text(
                          //         //       'No e-Service currently available',
                          //         //       style: TextStyle(
                          //         //           color: Colors.grey,
                          //         //           fontWeight: FontWeight.bold),
                          //         //     ),
                          //         //   ),
                          //         // );
                          //       } else {
                          //         return Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: SizedBox(
                          //             height: 200,
                          //             child: Scrollbar(
                          //               thickness: 8,
                          //               child: ListView.builder(
                          //                 scrollDirection: Axis.horizontal,
                          //                 itemCount: subsnapshot.data!.length,
                          //                 itemBuilder: (context, index) {
                          //                   return GestureDetector(
                          //                     onTap: () {
                          //                       if (GlobalVariables()
                          //                           .loggedIn) {
                          //                         Navigator.pushNamed(
                          //                             context, '/webpage',
                          //                             arguments: {
                          //                               'name': subsnapshot
                          //                                       .data[index]
                          //                                   ['name'],
                          //                               'url': subsnapshot
                          //                                           .data[index]
                          //                                       ['fullLink'] +
                          //                                   jwt,
                          //                             });
                          //                       } else {
                          //                         Navigator.push(
                          //                             context,
                          //                             MaterialPageRoute(
                          //                                 builder: (context) =>
                          //                                     const Login()));
                          //                       }
                          //                     },
                          //                     child: SizedBox(
                          //                       width: 350,
                          //                       child: Card(
                          //                         child: Padding(
                          //                           padding:
                          //                               const EdgeInsets.all(
                          //                                   8.0),
                          //                           child: Center(
                          //                             child: Text(
                          //                               subsnapshot.data[index]
                          //                                   ['name'],
                          //                               textAlign:
                          //                                   TextAlign.center,
                          //                               style: const TextStyle(
                          //                                   fontFamily: 'Gill',
                          //                                   fontSize: 20),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   );
                          //                 },
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       }
                          //     }),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        color: Colors.green,
                                        child: ExpansionTile(
                                          collapsedBackgroundColor:
                                              Colors.grey[200],
                                          collapsedIconColor: Colors.black,
                                          iconColor: Colors.white,
                                          title: Text(
                                            snapshot.data[index]['description'],
                                          ),
                                          textColor: Colors.white,
                                          children: const [
                                            Card(
                                              child: Column(
                                                children: [
                                                  Image(
                                                      image: AssetImage(
                                                          'assets/BirthParrenting.png')),
                                                  Text(
                                                    'BIRTH AND PARENTING',
                                                    style: TextStyle(
                                                        fontFamily: 'Gill'),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // FutureBuilder(
                                            //     future:
                                            //         fetchDataFromServiceAndAudience(
                                            //             snapshot.data[index]
                                            //                 ['id']),
                                            //     builder:
                                            //         (context, serviceSnapShot) {
                                            //       if (serviceSnapShot
                                            //               .connectionState ==
                                            //           ConnectionState.waiting) {
                                            //         return const Center(
                                            //           child:
                                            //               CircularProgressIndicator(),
                                            //         );
                                            //       } else if (serviceSnapShot
                                            //           .hasError) {
                                            //         return Center(
                                            //           child: Padding(
                                            //             padding:
                                            //                 const EdgeInsets
                                            //                     .all(8.0),
                                            //             child: Text(
                                            //                 'Error fetching data from Services: ${serviceSnapShot.error}'),
                                            //           ),
                                            //         );
                                            //       } else {
                                            //         return Container(
                                            //           color: Colors.white,
                                            //           child: ListView.builder(
                                            //               physics:
                                            //                   const NeverScrollableScrollPhysics(),
                                            //               shrinkWrap: true,
                                            //               itemCount:
                                            //                   serviceSnapShot
                                            //                       .data!.length,
                                            //               itemBuilder:
                                            //                   (context, index) {
                                            //                 return ListTile(
                                            //                   title: Text(
                                            //                     serviceSnapShot
                                            //                             .data?[
                                            //                         index]['name'],
                                            //                   ),
                                            //                   onTap: () {
                                            //                     Navigator.pushNamed(
                                            //                         context,
                                            //                         '/webpage',
                                            //                         arguments: {
                                            //                           'url':
                                            //                               // serviceSnapShot.data?[index]
                                            //                               //         [
                                            //                               //         'fullLink'] +
                                            //                               'https://beta.eservices.gov.za/epglum/epermit?id=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZWd3YXRsaGVAZ21haWwuY29tIn0.YQdeaxE_QA0aZy25p-t3Jd-weoIi4D4UIct-5QTnLAs',
                                            //                           'name': serviceSnapShot
                                            //                                   .data?[index]
                                            //                               [
                                            //                               'name']
                                            //                         });
                                            //                   },
                                            //                 );
                                            //               }),
                                            //         );
                                            //       }
                                            //     })
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

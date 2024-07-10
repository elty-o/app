import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/eservices/eservices.dart';
//import 'package:flutter_application_1/features/about.dart';
import 'package:flutter_application_1/features/use_case_3/favorites.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter_application_1/features/categories.dart';
import 'package:flutter_application_1/features/use_case_1/homescreen.dart';
import 'package:flutter_application_1/features/use_case_1/login.dart';
//import 'package:flutter_application_1/features/notifications.dart';
import 'package:flutter_application_1/presentation/drawer.dart';
//import 'package:flutter_application_1/features/satisfaction_survey.dart';
//import 'package:flutter_application_1/features/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_application_1/core/globals.dart';
//import 'package:android_intent/android_intent.dart';
//import 'package:store_redirect/store_redirect.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String serverName = GlobalVariables.server; //'https://beta.eservices.gov.za';
//bool home = true;

class _HomeState extends State<Home> {
  //Map<String, String> bottomNavigation = TextService.bottomNavigation;

  List<String> eImages = [
    'assets/BirthParrenting.png',
    'assets/Health.png',
    'assets/Education.png',
    'assets/AgricultureLand.png',
    'assets/ArtsCultureSport.png',
    'assets/BusinessEconomics.png',
    'assets/ConsumerProtection.png',
    'assets/CitizenshipImmigration.png',
    'assets/Environment.png',
    'assets/MoneyTax.png',
    'assets/LegalDefence.png',
    'assets/Transport.png',
    'assets/SocialServices.png',
    'assets/RetirementDeath.png',
    'assets/EmploymentLabour.png',
    'assets/Housing.png',
  ];

  List<String> trending = ['e-PGLUM'];

  List<String> trendingImages = ['assets/latest/pglum.jpg'];

  List<String> latest = ['DESTEA', 'DFFE', 'e-PGLUM'];

  List<String> latestImages = [
    'assets/latest/destea.jpg',
    'assets/latest/permit.jpg',
    'assets/latest/pglum.jpg'
  ];

  List<String> latestSubtitle = [
    'It is the home to more than 22000 indigenous plants',
    'Seda was established in December 2004',
    'Seda was established in December 2004'
  ];

  List<String> bannerImages = [
    // 'assets/banners/eservices.gov.za_mainbanner_1.jpg',
    // 'assets/banners/eservices.gov.za_mainbanner_2.jpg',
    // 'assets/banners/eservices.gov.za_mainbanner_3.jpg'
    'assets/ads/ad1.jpg',
    'assets/ads/ad3.jpg',
    'assets/ads/ad4.jpg'
  ];

  List<String> eservices = [
    '$serverName/epglum/epermit?id=${GlobalVariables().token}',
  ];

  String url =
      'https://play.google.com/store/apps/details?id=za.gov.sa_gov_app';

  //Get the list of audiences
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response =
        await http.get(Uri.parse('$serverName/tonkana/audience.php'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Get the amount of e-Services

  int currentIndex = 0;
  final List<Widget> bottomItems = [
    const HomeScreen(),
    //const Categories(),
    const EServices(),
    const Favorites(),
    //const SatisfactionSurvey(),
    //const AboutUs()
  ];

  int screenToDisplay = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Image(
        //         height: 40,
        //         image: AssetImage('assets/appbar/appbar.png'),
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Image(
        //         height: 30,
        //         image: AssetImage('assets/appbar/ndp.png'),
        //       ),
        //       SizedBox(
        //         width: 30,
        //       ),
        //       Image(
        //         height: 30,
        //         image: AssetImage('assets/appbar/saflag.png'),
        //       ),
        //     ],
        //   ),
        // actions: [
        //   IconButton(
        //       style:
        //           const ButtonStyle(iconSize: MaterialStatePropertyAll(30)),
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const Notifications()));
        //       },
        //       icon: const Icon(Icons.phone_in_talk_sharp)),
        //   IconButton(
        //     style: const ButtonStyle(iconSize: MaterialStatePropertyAll(30)),
        //     icon: const Icon(
        //       Icons.account_box_rounded,
        //     ),
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => const Login()));
        //     },
        //   ),
        // ],
        //),
        appBar: AppBarDesign().mainAppBar(),
        endDrawer: DrawerDesign().mainDrawer(context),
        body: bottomItems[currentIndex],
        bottomNavigationBar: Stack(
          children: [
            BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                  bottomItems[currentIndex];
                  debugPrint(bottomItems[currentIndex].toString());
                  //home = !home;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: AppLocalizations.of(context)!.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  label: AppLocalizations.of(context)!.categories,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: AppLocalizations.of(context)!.favorites,
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.feed_outlined),
                //   label: 'Feedback',
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.info_outline),
                //   label: 'About Us',
                // ),
              ],
            ),
            const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image(image: AssetImage('assets/footer.png'))),
          ],
        ));
  }

  Widget homeScreen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: bannerImages.map((bannerImages) {
                debugPrint('IN THE CAR');
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(bannerImages),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                  height: 70, autoPlay: true, enlargeCenterPage: true)),
          // const Image(
          //     image: AssetImage(
          //   'assets/ads/ad1.jpg',
          // )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('LATEST',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gill')),
          ),
          SizedBox(
            height: 250,
            child: Scrollbar(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  3,
                  (index) => SizedBox(
                    width: 200,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                  height: 150,
                                  width: 150,
                                  image: AssetImage(latestImages[index])),
                            ),
                            Text(
                              latest[index],
                              style: const TextStyle(
                                  fontFamily: 'Gill',
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   latestSubtitle[index],
                            //   style:
                            //       const TextStyle(fontFamily: 'Gill'),
                            // ),
                            // Row(
                            //   children: [
                            //     ElevatedButton(
                            //         onPressed: () {
                            //           StoreRedirect.redirect(
                            //               androidAppId:
                            //                   "com.interactech.csa",
                            //               iOSAppId: "");
                            //           // try {
                            //           //   const AndroidIntent intent =
                            //           //       AndroidIntent(
                            //           //     action: 'action_view',
                            //           //     data:
                            //           //         'market://play.google.com/store/apps/details?id=za.gov.sa_gov_app', // Replace with your app's package name
                            //           //   );

                            //           //   intent.launch();
                            //           // } catch (e) {
                            //           //   debugPrint(
                            //           //       "Error launching Google Play Store: $e");
                            //           // }

                            //           // Navigator.pushNamed(
                            //           //     context, '/webpage',
                            //           //     arguments: {
                            //           //       'name': 'App Store',
                            //           //       'url': url,
                            //           //     });
                            //         },
                            //         child: const Text(
                            //           'Install',
                            //           style: TextStyle(
                            //               color: Colors.orange,
                            //               fontWeight:
                            //                   FontWeight.bold),
                            //         )),
                            //     // Need to either add or remove this button.;
                            //     // IconButton(
                            //     //   onPressed: () {
                            //     //     debugPrint('Nav');
                            //     //   },
                            //     //   icon: const Icon(
                            //     //     Icons.add_circle,
                            //     //     color: Colors.grey,
                            //     //   ),
                            //     //   color: Colors.black,
                            //     // )
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //const Image(image: AssetImage('assets/ads/ad2.jpg')),
          // YoutubePlayer(
          //   controller: YoutubePlayerController(
          //       initialVideoId: 'jXNw6hSlct4',
          //       flags: const YoutubePlayerFlags(autoPlay: false, mute: false)),
          //   showVideoProgressIndicator: true,
          // ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('TRENDING',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gill')),
          ),
          SizedBox(
            height: 150,
            child: Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 300,
                        child: Card(
                            elevation: 5,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      constraints: const BoxConstraints(
                                          maxHeight: 100, maxWidth: 100),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image(
                                          image:
                                              AssetImage(trendingImages[index]),
                                          height: 90,
                                          width: 90,
                                        ),
                                      )),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            trending[index],
                                            style: const TextStyle(
                                                fontFamily: 'Gill',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (GlobalVariables().loggedIn) {
                                                Navigator.pushNamed(
                                                    context, '/webpage',
                                                    arguments: {
                                                      'name': trending[index],
                                                      'url': eservices[index]
                                                    });
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Login()));
                                              }
                                            },
                                            icon: const Icon(
                                                Icons.arrow_circle_right),
                                            color: Colors.grey,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

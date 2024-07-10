import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/use_case_1/register.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // These values are in the Text Services as well.
  //String latestHeading = TextService.latestHeading;
  //String trendingHeading = TextService.trendingHeading;

  // void toChangeText() async {
  //   final translatedData =
  //       await TranslationService.translate(TextService.homeScreenTextFields);

  //   setState(() {
  //     latestHeading = translatedData['latest'] ?? '';
  //     trendingHeading = translatedData['trending'] ?? '';
  //     debugPrint(translatedData['latest']);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    //toChangeText();
  }

  String serverName = GlobalVariables.server;

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

  List<String> latest = ['DFFE', 'e-PGLUM']; //'DESTEA', Removed

  List<String> latestImages = [
    //'assets/latest/destea.jpg',
    'assets/latest/permit.jpg',
    'assets/latest/pglum.jpg'
  ];

  List<String> latestSubtitle = [
    //'It is the home to more than 22000 indigenous plants',
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
    '${GlobalVariables.server}/epglum/epermit?id=${GlobalVariables().token}',
  ];

  String url =
      'https://play.google.com/store/apps/details?id=za.gov.sa_gov_app';
  int carousalAmount = 0;

////////////////////////////////////////////////////////////
  /// WildFly Validation
  /// //////////////////////////////////////////////////////

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> userValidationViaWildFly(
      String username, String password) async {
    final response = await http.post(
        Uri.parse(GlobalVariables().userAuthentication),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"username": "$username", "password": "$password"}));
    Map<String, dynamic> sConvert = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (username == sConvert['email']) {
        GlobalVariables().token = sConvert['token'] ?? '';
        GlobalVariables().username = sConvert['name'] ?? '';
        GlobalVariables().secondName = sConvert['secondName'] ?? '';
        GlobalVariables().thirdName = sConvert['thirdName'] ?? '';
        GlobalVariables().userSurname = sConvert['surname'] ?? '';
        GlobalVariables().cellphoneNumber = sConvert['phoneNumber'] ?? '';
        GlobalVariables().location = sConvert['name'] ?? '';
        GlobalVariables().userEmail = sConvert['email'];
        GlobalVariables().idNumber = sConvert['idNumber'] ?? '';
        GlobalVariables().passpord = sConvert['passport'] ?? '';

        setState(() {
          GlobalVariables().loggedIn = true;
          debugPrint(GlobalVariables().token);
          // Navigator.pushNamed(context, '/webpage', arguments: {
          //   'url':
          //       // serviceSnapShot.data?[index]
          //       //         [
          //       //         'fullLink'] +
          //       'https://beta.eservices.gov.za/epglum/epermit?id=$jwt',
          //   'name': 'Land Services'
          // });
          //status = true;
        });
        //Navigator.pop(context);
        //Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        Navigator.popAndPushNamed(context, '/webpage', arguments: {
          'url':
              // serviceSnapShot.data?[index]
              //         [
              //         'fullLink'] +
              '${GlobalVariables.server}/epglum/epermit?id=${GlobalVariables().token}',
          'name': 'Land Services'
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${sConvert['description']}'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('System error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: bannerImages.map((bannerImages) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        if (bannerImages == 'assets/ads/ad1.jpg') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: AlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .notification),
                                  content: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image(
                                            image: AssetImage(
                                                'assets/ads/ad1.jpg')),
                                        Text(AppLocalizations.of(context)!
                                            .releaseNotification),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .close),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (bannerImages == 'assets/ads/ad4.jpg') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 10,
                                child: AlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .advertisement),
                                  content: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image(image: AssetImage(bannerImages)),
                                        Text(
                                            '${AppLocalizations.of(context)!.advertisementMessage} egovsupport@sita.co.za'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .close),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        //height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          //color: Colors.amber,
                          borderRadius: BorderRadius.circular(2.0),
                          image: DecorationImage(
                            image: AssetImage(bannerImages),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                pauseAutoPlayOnManualNavigate: true,
                onPageChanged: (index, reason) => {
                  setState(() {
                    carousalAmount = index;
                  })
                },
              )),
          // const Image(
          //     image: AssetImage(
          //   'assets/ads/ad1.jpg',
          // )),
          Center(
              child: Text(
            '${carousalAmount + 1}/${bannerImages.length}',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          )),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.latest /*latestHeading*/,
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
                  2,
                  (index) => SizedBox(
                    width: 200,
                    child: GestureDetector(
                      onTap: () {
                        //debugPrint('$index -------> THIS IS THE INDEX');
                        if (index == 0) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Environment()));
                        } else {}
                      },
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
          ),
          //const Image(image: AssetImage('assets/ads/ad2.jpg')),
          // YoutubePlayer(
          //   controller: YoutubePlayerController(
          //       initialVideoId: 'jXNw6hSlct4',
          //       flags: const YoutubePlayerFlags(autoPlay: false, mute: false)),
          //   showVideoProgressIndicator: true,
          // ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.newsFeeds,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gill')),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 8,
              child: ListTile(
                //leading: Icon(Icons.newspaper_rounded),
                title: Text(AppLocalizations.of(context)!.southAfricanNews),
                onTap: () {
                  Navigator.pushNamed(context, '/webpage',
                      arguments: {'url': 'https://www.sanews.gov.za/'});
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => NewsFeeds()));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                AppLocalizations.of(context)!.trending /*trendingHeading*/,
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
                                            iconSize: 50,
                                            onPressed: () {
                                              if (GlobalVariables().loggedIn) {
                                                Navigator.pushNamed(
                                                    context, '/webpage',
                                                    arguments: {
                                                      'name': trending[index],
                                                      'url': eservices[index]
                                                    });
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Authentication'),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Semantics(
                                                                    label:
                                                                        'Enter your username',
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          _usernameController,
                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        // errorText: _usernameController.text.length > 0
                                                                        //     ? null
                                                                        //     : 'Password is required',

                                                                        hoverColor:
                                                                            Colors.green,
                                                                        labelText:
                                                                            'Username',

                                                                        labelStyle:
                                                                            TextStyle(color: Colors.grey),
                                                                        focusColor:
                                                                            Colors.green,
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.green),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          16.0),
                                                                  Semantics(
                                                                    label:
                                                                        'Enter your password',
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          _passwordController,

                                                                      cursorColor:
                                                                          Colors
                                                                              .green,
                                                                      obscureText:
                                                                          true,
                                                                      // onTapOutside: (value) {
                                                                      //   validatePassword(value);
                                                                      // },
                                                                      // onChanged: (value) {
                                                                      //   validatePassword(value);
                                                                      // },
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hoverColor:
                                                                            Colors.green,
                                                                        labelText:
                                                                            'Password',
                                                                        // errorText: _passwordController.text.length > 0
                                                                        //     ? null
                                                                        //     : 'Password is required', //Error only to display when user clicks Login
                                                                        focusColor:
                                                                            Colors.green,
                                                                        labelStyle:
                                                                            const TextStyle(color: Colors.grey),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.green),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          32.0),
                                                                  Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.green,
                                                                              foregroundColor: Colors.white // Set the button color to green
                                                                              ),
                                                                          onPressed:
                                                                              () {
                                                                            if (_usernameController.value.text.isNotEmpty ||
                                                                                _passwordController.value.text.isNotEmpty) {
                                                                              userValidationViaWildFly(_usernameController.value.text, _passwordController.value.text);
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text('Username and password cannot be empty'),
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                          child:
                                                                              const Text('LOGIN'),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5.0),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.green,
                                                                              foregroundColor: Colors.white // Set the button color to green
                                                                              ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text('CANCEL'),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
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

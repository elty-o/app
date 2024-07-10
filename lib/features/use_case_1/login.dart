import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/use_case_1/forgotpassword.dart';
import 'package:flutter_application_1/features/use_case_1/forgotusername.dart';
//import 'package:flutter_application_1/features/home.dart';
//import 'package:flutter_application_1/presentation/drawer.dart';
//import 'package:flutter_application_1/features/home.dart';
import 'package:flutter_application_1/features/use_case_1/register.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/core/globals.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String server = GlobalVariables.server;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordValid = true;

  bool status = GlobalVariables().loggedIn;
  String user = GlobalVariables().user;

  bool obscureTextController = true;

  // Future<void> validatePassword(String enteredPassword) async {
  //   final expectedHash = await fetchExpectedHash(enteredPassword);
  //   setState(() {
  //     isPasswordValid = expectedHash != null &&
  //         sha256.convert(utf8.encode(enteredPassword)).toString() ==
  //             expectedHash;
  //   });
  // }

  Future<void> validatePassword(String enteredPassword) async {
    bool isValid = await _isPasswordValid(enteredPassword);
    setState(() {
      isPasswordValid = isValid;
    });
  }

  Future<String?> fetchExpectedHash(String enteredPassword) async {
    debugPrint('--------------------------- LOGIN RESPONSE');

    try {
      final response = await http.post(
          Uri.parse(GlobalVariables()
              .userAuthentication), //await http.post(Uri.parse("$server/tnk/login.php"),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: {
            'enteredPassword': enteredPassword,
            'email': _usernameController.text
          });
      debugPrint('${response.body} --------------------------- LOGIN RESPONSE');

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return result['isValid'];
      } else {
        debugPrint("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint('Error Fetch Expected Hash: $e');
      return null;
    }
  }

  // Future<void> login() async {
  //   debugPrint('This is the text controller: ${_passwordController.text}');

  //   if (isPasswordValid) {
  //     debugPrint('Logged in');
  //     setState(() {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => const Home()));
  //     });
  //   } else {
  //     debugPrint('Login Failed');
  //   }
  // }

  Future<bool> _isPasswordValid(String enteredPassword) async {
    final expectedHash = await fetchExpectedHash(enteredPassword);
    if (expectedHash != null) {
      String enteredHash =
          sha256.convert(utf8.encode(enteredPassword)).toString();
      return enteredHash == expectedHash;
    } else {
      return false;
    }
  }

  /////////////////////////////////////////////////////////////////////////
  ///WILD FLY API CALL
  //////////////////////////////////////////////////////////////////////////

  Future<void> userValidationViaWildFly(
      String username, String password) async {
    final response = await http.post(
        Uri.parse(GlobalVariables().userAuthentication),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"username": "$username", "password": "$password"}));
    Map<String, dynamic> sConvert = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (username == sConvert['email']) {
        GlobalVariables().userId = sConvert['userId'] ?? '';
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

          //status = true;
        });
        debugPrint('THIS IS THE USER ID: ${GlobalVariables().userId}');
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
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
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      ),
      //endDrawer: DrawerDesign().mainDrawer(),
      body: status
          ? logout()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 800,
                    height: 50,
                    color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          AppLocalizations.of(context)!.loginAppBarTitle,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gill')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        Semantics(
                          label: AppLocalizations.of(context)!.enter_username,
                          child: TextField(
                            maxLength: 100,
                            controller: _usernameController,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                              // errorText: _usernameController.text.length > 0
                              //     ? null
                              //     : 'Password is required',
                              icon: Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                              hoverColor: Colors.green,
                              labelText: AppLocalizations.of(context)!.username,

                              labelStyle: TextStyle(color: Colors.grey),
                              focusColor: Colors.green,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Semantics(
                          label: AppLocalizations.of(context)!.enter_password,
                          child: TextField(
                            controller: _passwordController,

                            cursorColor: Colors.green,
                            obscureText: obscureTextController,
                            // onTapOutside: (value) {
                            //   validatePassword(value);
                            // },
                            // onChanged: (value) {
                            //   validatePassword(value);
                            // },
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureTextController =
                                          !obscureTextController;
                                    });
                                  },
                                  child: obscureTextController
                                      ? Icon(Icons.visibility_off_outlined)
                                      : Icon(Icons.visibility_outlined)),
                              icon: const Icon(
                                Icons.key,
                                color: Colors.green,
                              ),
                              hoverColor: Colors.green,
                              labelText: AppLocalizations.of(context)!.password,
                              // errorText: _passwordController.text.length > 0
                              //     ? null
                              //     : 'Password is required', //Error only to display when user clicks Login
                              focusColor: Colors.green,
                              labelStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors
                                        .white // Set the button color to green
                                    ),
                                onPressed: () {
                                  if (_usernameController
                                          .value.text.isNotEmpty ||
                                      _passwordController
                                          .value.text.isNotEmpty) {
                                    userValidationViaWildFly(
                                        _usernameController.value.text,
                                        _passwordController.value.text);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Username and password cannot be empty'),
                                      ),
                                    );
                                  }

                                  // await validatePassword(
                                  //     _passwordController.text);
                                  // if (_usernameController
                                  //         .value.text.isNotEmpty ||
                                  //     _passwordController
                                  //         .value.text.isNotEmpty) {
                                  //   if (isPasswordValid) {
                                  //     setState(() {
                                  //       GlobalVariables().loggedIn = true;
                                  //       GlobalVariables().user =
                                  //           _usernameController.text;
                                  //       Navigator.of(context)
                                  //           .pushNamedAndRemoveUntil(
                                  //               '/', (route) => false);
                                  //       // Navigator.pop(context);
                                  //       // Navigator.push(
                                  //       //     context,
                                  //       //     MaterialPageRoute(
                                  //       //         builder: (context) =>
                                  //       //             const Home()));
                                  //       //Navigator.pop(context);
                                  //     });
                                  //   } else {
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(
                                  //       SnackBar(
                                  //         content: Text(
                                  //             'Invalid username or password'),
                                  //       ),
                                  //     );
                                  //   }
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //       content: Text(
                                  //           'Username and password is required'),
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: Text(
                                    AppLocalizations.of(context)!.loginButton),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .registerButton),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Column(
                          children: [
                            const Text(
                              'Forgot: ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            // GestureDetector(
                            //   child: const Text(
                            //     'Username',
                            //     style: TextStyle(
                            //       color: Colors.grey,
                            //     ),
                            //   ),
                            //   onTap: () {
                            //     debugPrint('Username');
                            //   },
                            // ),
                            // const SizedBox(height: 10.0),
                            // const Text('/'),
                            // const SizedBox(height: 10.0),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .forgotUsernameText,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotUsername()));
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            GestureDetector(
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .forgotPasswordText,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20)),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget logout() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 800,
            height: 50,
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  '${AppLocalizations.of(context)!.logout}: ${GlobalVariables().username} ${GlobalVariables().userSurname}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gill')),
            ),
          ),
          const Image(image: AssetImage('assets/logout.jpg')),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppLocalizations.of(context)!.logoutMessage,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        child: IconButton(
                            onPressed: () async {
                              // debugPrint('Phone');
                              // String phoneNumber = '0801414882';
                              // String url = 'tel:$phoneNumber';

                              // if (await canLaunchUrl(Uri.parse(url))) {
                              //   await launchUrl(Uri.parse(url));
                              // } else {
                              //   throw 'Could not launch $url';
                              // }
                            },
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(width: 150, child: Text('080 141 4882')),
                    ],
                  ),
                ],
              ),
            ]),
            // child: ListTile(
            //   title: const Text('Phone'),
            //   leading: const Icon(
            //     Icons.phone,
            //     color: Colors.green,
            //   ),
            //   subtitle: const Text('080 141 4882'),
            //   onTap: () async {
            //     String phoneNumber = '0801414882';
            //     String url = 'tel:$phoneNumber';

            //     if (await canLaunchUrl(Uri.parse(url))) {
            //       await launchUrl(Uri.parse(url));
            //     } else {
            //       throw 'Could not launch $url';
            //     }
            //   },
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          child: IconButton(
                            icon: const Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              debugPrint(
                                  AppLocalizations.of(context)!.emailText);
                              //sendEmail();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 150, child: Text('egovsupport@sita.co.za')),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {
                GlobalVariables().loggedIn = false;
                GlobalVariables().username = 'Not Logged In';
                GlobalVariables().userSurname = '';
                GlobalVariables().userEmail = '';
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
                //Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.logoutButtonText,
                style: TextStyle(fontFamily: 'Gill'),
              )),
        ],
      ),
    );
  }

  // void sendEmail() async {
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'egovsupport@sita.co.za',
  //   );

  //   if (await canLaunchUrl(emailLaunchUri)) {
  //     await launchUrl(emailLaunchUri);
  //   } else {
  //     throw 'Could not launch $emailLaunchUri';
  //   }
  // }
}

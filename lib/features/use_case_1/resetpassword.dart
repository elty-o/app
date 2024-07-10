import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
//import 'package:flutter_application_1/core/obtainotp.dart';
import 'package:flutter_application_1/features/use_case_1/login.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResetPasswordScreen(),
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _resetPassword(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset successful.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  String password = '';
  bool passwordStrengthSecure = false;
  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(value)) {
      setState(() {
        password = value;
      });
      return true;
    } else {
      setState(() {
        password = '';
      });
      return false;
    }
  }

  // void toaster(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     textColor: Colors.green,
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  // }

  //RESEND OTP
  Future<void> validateNewUser(String email) async {
    //debugPrint('$email------------- ON RESET THIS IS THE EMAIL');
    // GlobalVariables().userData = {
    //   "email": GlobalVariables().userData['email'].toString(),
    //   "idNumber": GlobalVariables().userData['idNumber'].toString(),
    //   "cellHome": GlobalVariables().userData['cellHome'].toString(),
    // };

    //validateNewUser(String email, String idNumber, String cellphone) PREVIOUSLY USED
    // void toaster(String message) {
    //   Fluttertoast.showToast(
    //     msg: message,
    //     textColor: Colors.green,
    //     toastLength: Toast.LENGTH_LONG,
    //   );
    // }

    //debugPrint('his is before response from update password');

    //final Map<String, String> userData = GlobalVariables().userData;
    final String endPoint = GlobalVariables().resetPassword;
    final String pathParams = email; //'${userData[email]}';
    final String resourceURL = '$endPoint$pathParams';

    //.validateNewUserEndPoint; //'$server/tonkana/rest/users/adduser'; PREVIOUSLY USED

    //debugPrint('IN BEFORE GET ${userData['email']}');

    //debugPrint(resourceURL);

    //final response = await http.get(Uri.parse(resourceURL));
    final response = await http.get(Uri.parse(resourceURL));
    //String jString = response.body;
    debugPrint('Weve entered the new validation method = ${response.body}');
    Map<String, dynamic> sConvert = jsonDecode(response.body);

    //String val = jString['key'];

    //debugPrint('--------------------RESET PASSWORD RESPONSE ${sConvert['otp']}');

    if (response.statusCode == 200) {
      String responseBody = response.body;
      bool isNumber = RegExp(r'\d').hasMatch(responseBody);
      if (isNumber) {
        //Assign for reset password
        GlobalVariables().forgotPasswordOtp = sConvert['otp'];
        debugPrint('Go to the reset screen: ${response.body}');
        //navigationPossible = true;
      } else {
        debugPrint('User detail already exist');
      }
    } else {
      debugPrint('System error: ${response.body}');
      if (response.body.contains('Number is already in use')) {
        //toaster('ID Number already exist');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ID Number already exist.'),
          ),
        );
      } else if (response.body.contains('Cellphone')) {
        //toaster('Cellphone already exist');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cellphone already exist.'),
          ),
        );
      } else if (response.body.contains('email')) {
        //toaster('Email address already exist');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email address already exist.'),
          ),
        );
      } else {
        //toaster('We are unable to register you, please contact support team.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'We are unable to register you, please contact support team.'),
          ),
        );
      }

      // if (response.statusCode != 200) {
      //   toaster('System error or network error.');
      // } else {
      //   toaster('User validation error:  ${response.body}');
      // }
    }

    debugPrint(
        'validateNewUser()     END 1111111111111111111111111111111111111111111111111111111111111111111111111111111');
  }

//TODO PASSWORD IS NOT BEING RESET: CALL -> https://beta.eservices.gov.za/rest/members/updatepassword/
  Future<void> updateUserPassword(String email, String password) async {
    debugPrint('$password -------------------------------- PASSWORD');
    final updateResponse = await http.post(
        Uri.parse(GlobalVariables().updatePassword),
        headers: {'Content-Type': '	application/json'},
        body: jsonEncode({"username": "$email", "password": "$password"}));

    debugPrint(
        '${updateResponse.body} ----------------------- attempt to update');

    if (updateResponse.statusCode == 200) {
      if (updateResponse.body.contains('success')) {
        navigator();
      } else {
        debugPrint('Cannot reset users password');
      }
    } else {
      // toaster(
      //     'We are unable to reset your password, please contact support team.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'We are unable to reset your password, please contact support team.'),
        ),
      );
    }
    //debugPrint('his is before response from update password');

    //final Map<String, String> userData = GlobalVariables().userData;

    //PREVIOUSLY USED 20240205
    // final String pathParams = '/$email/$password';
    // final String endPoint = GlobalVariables()
    //     .updateUserPasswordEndPoint; //'$server/tonkana/rest/users/adduser';
    // final String resourceURL = '$endPoint$pathParams';

    // debugPrint('IN BEFORE GET $email THIS IS PASSWORD $password');

    //debugPrint(resourceURL);

    //final response = await http.post(Uri.parse(resourceURL));
    //PREVIOUSLY USED 20240205
    // final response = await http.post(Uri.parse(endPoint),
    //     headers: {
    //       'Content-Type': 'application/json',
    //     },
    //     body: jsonEncode({'username': email, 'password': password}));

    // debugPrint(
    //     '${response.body} ---------------- This is to reset the password');
  }

  void navigator() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String email = args['email'];
    debugPrint('ON RESET SCREEN THIS IS THE PASSWORD: $email');
    // final String cellHome = args['cellHome'];

    //GetAnOtp().sendOtp(email, cellHome);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 800,
              height: 50,
              color: Colors.green,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('RESET PASSWORD',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gill')),
              ),
            ),
            const SizedBox(
                child: Image(image: AssetImage('assets/forgotpassword.jpg'))),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _otpController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'OTP',
                      hintText: 'Enter your OTP',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter your new password',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your new password',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor:
                                Colors.white // Set the button color to green
                            ),
                        onPressed: () {
                          if (GlobalVariables().forgotPasswordOtp ==
                              _otpController.text) {
                            if (_newPasswordController.text ==
                                _confirmPasswordController.text) {
                              passwordStrengthSecure = validatePassword(
                                  _newPasswordController.value.text);
                              if (passwordStrengthSecure) {
                                updateUserPassword(
                                    email, _newPasswordController.value.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Password must be alphanumeric, contain at least one uppercase, lowercase and special character'),
                                  ),
                                );
                              }
                              // if (_newPasswordController.text.length >= 8) {
                              //   updateUserPassword(
                              //       email, _newPasswordController.value.text);
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text(
                              //           'Password must be greater than 7 characters'),
                              //     ),
                              //   );
                              // }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('New passwords do not match.'),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('OTP does not match'),
                              ),
                            );
                          }
                        },
                        child: const Text('Reset Password'),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            debugPrint('new opt');
                            validateNewUser(email);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor:
                                  Colors.white // Set the button color to green
                              ),
                          child: const Text('RESEND OTP')),
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
}

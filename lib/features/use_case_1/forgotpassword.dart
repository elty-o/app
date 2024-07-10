import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/core/globals.dart';
import 'dart:convert';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

bool navigationPossible = false;

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _cellphoneController = TextEditingController();

  Future<void> validateNewUser(String email) async {
    final String endPoint = GlobalVariables().resetPassword;
    final String pathParams = email; //'${userData[email]}';
    final String resourceURL = '$endPoint$pathParams';

    final response = await http.get(Uri.parse(resourceURL));

    debugPrint('Weve entered the new validation method = ${response.body}');
    Map<String, dynamic> sConvert = jsonDecode(response.body);

    if (response.statusCode == 200) {
      String responseBody = response.body;
      bool isNumber = RegExp(r'\d').hasMatch(responseBody);
      if (isNumber) {
        GlobalVariables().forgotPasswordOtp = sConvert['otp'];
        debugPrint('Go to the reset screen: ${response.body}');
        navigationPossible = true;
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
    }

    debugPrint(
        'validateNewUser()     END 1111111111111111111111111111111111111111111111111111111111111111111111111111111');
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password'),
          ),
        );
      }
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 800,
                height: 50,
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('FORGOT PASSWORD',
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
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 100,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email.';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors
                                    .white // Set the button color to green
                                ),
                            onPressed: () async {
                              await validateNewUser(
                                _emailController.value.text,
                              );
                              if (navigationPossible) {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                      'Password has been updated successfully.'),
                                  duration: Duration(seconds: 3),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                Future.delayed(snackBar.duration, () {
                                  Navigator.pushNamed(context, '/resetpassword',
                                      arguments: {
                                        'email': _emailController.value.text,
                                        'cellHome':
                                            _cellphoneController.value.text
                                      });
                                });
                              }
                            },
                            child: const Text('RESET PASSWORD'),
                          ),
                          const SizedBox(width: 16.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors
                                    .white // Set the button color to green
                                ),
                            onPressed: () async {
                              await validateNewUser(
                                _emailController.value.text,
                              );

                              if (navigationPossible) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('CANCEL'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

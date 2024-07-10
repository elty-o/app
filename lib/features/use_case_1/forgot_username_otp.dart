import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotUsernameOtp extends StatefulWidget {
  const ForgotUsernameOtp({super.key});

  @override
  State<ForgotUsernameOtp> createState() => _ForgotUsernameOtpState();
}

class _ForgotUsernameOtpState extends State<ForgotUsernameOtp> {
  TextEditingController otpController = TextEditingController();

  Future<void> resendOtp(String desc, String id, String username) async {
    final response = await http.post(
        Uri.parse('${GlobalVariables().requestUsernameOtpEndPoint}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"description": "$desc", "identification": "$id"}));
    Map<String, dynamic> sConvert = jsonDecode(response.body);
    // debugPrint('${response.body}');
    // TODO: Status Code to be added to a Constant variable
    if (response.statusCode == 200) {
      String responseBody = response.body;
      //TODO CREATE GLOBAL FUNCTION
      bool isNumber = RegExp(r'\d').hasMatch(responseBody);
      if (isNumber) {
        GlobalVariables().forgotUsernameOtp = sConvert['otp'];
        return;
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${sConvert['error']}'),
            ),
          );
        });
      }
      //THIS IS WHERE WE NEED TO ROUTE THE USER
      // Navigator.pushNamed(context, '/forgot_username_otp',
      //     arguments: {'description': desc, 'id': id, 'username': username});
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not resend an otp, please try again.'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String description = args['description'];
    final String id = args['id'];
    final String username = args['username'] ?? '';
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
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter OTP',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your otp number.';
              }

              return null;
            },
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor:
                        Colors.white // Set the button color to green
                    ),
                onPressed: () async {
                  //THIS IS FOR TESTING REMOVE ASAP
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => UpdateUsername()));
                  // debugPrint(
                  //     '${GlobalVariables().forgotUsernameOtp} == $otpController');
                  if (GlobalVariables().forgotUsernameOtp ==
                      otpController.value.text) {
                    Navigator.pushNamed(context, '/update_username',
                        arguments: {
                          'description': description,
                          'id': id,
                          'username': username
                        });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Otp does not match.'),
                      ),
                    );
                  }
                },
                child: const Text('CONFIRM OTP'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor:
                        Colors.white // Set the button color to green
                    ),
                onPressed: () async {
                  // if (identityValue == 0) {
                  //   identityValueDescription = 'idnumber';
                  // } else {
                  //   identityValueDescription = 'passport';
                  // }
                  resendOtp(description, id, username);
                },
                child: const Text('RESEND OTP'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor:
                        Colors.white // Set the button color to green
                    ),
                onPressed: () async {
                  // if (identityValue == 0) {
                  //   identityValueDescription = 'idnumber';
                  // } else {
                  //   identityValueDescription = 'passport';
                  // }
                  Navigator.pop(context);
                },
                child: const Text('CANCEL'),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

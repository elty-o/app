import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotUsername extends StatefulWidget {
  const ForgotUsername({super.key});

  @override
  State<ForgotUsername> createState() => _ForgotUsernameState();
}

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
      //TODO: We need to tell the user something
    } else if (response.body.contains('Cellphone')) {
      //TODO: We need to tell the user something
    } else if (response.body.contains('email')) {
      //TODO: We need to tell the user something
    } else {
      //TODO: We need to tell the user something
    }
  }

  debugPrint(
      'validateNewUser()     END 1111111111111111111111111111111111111111111111111111111111111111111111111111111');
}

class _ForgotUsernameState extends State<ForgotUsername> {
  TextEditingController identificationController = TextEditingController();

  Future<void> sendOtp(String description, String id) async {
    final response = await http.post(
        Uri.parse('${GlobalVariables().requestUsernameOtpEndPoint}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {"description": "$description", "identification": "$id"}));
    Map<String, dynamic> getOtp = jsonDecode(response.body);

    if (response.statusCode == 200) {
      GlobalVariables().forgotUsernameOtp = getOtp['otp'];
      //GlobalVariables().username = getOtp['username'];
      debugPrint(getOtp['otp']);
      setState(() {
        Navigator.pushNamed(context, '/forgot_username_otp', arguments: {
          'description': description,
          'id': id,
          'username': getOtp['username']
        });
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username invalid'),
          ),
        );
      });
    }
  }

  int? identityValue = 0;
  String identityValueDescription = '';
  String info =
      'An OTP will be sent to you via SMS and Email using your cellphone number and e-mail address that are in our records';
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
        child: Column(
          children: [
            Container(
              width: 800,
              height: 50,
              color: Colors.green,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('FORGOT USERNAME',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gill')),
              ),
            ),
            const SizedBox(
                child: Image(image: AssetImage('assets/forgotpassword.jpg'))),
            ListTile(
              title: Text(info),
              leading: Icon(Icons.info),
            ),
            RadioListTile(
                title: Text('ID Number'),
                value: 0,
                groupValue: identityValue,
                onChanged: (value) {
                  setState(() {
                    identityValue = value;
                  });
                }),
            RadioListTile(
                title: Text('Passport Number'),
                value: 1,
                groupValue: identityValue,
                onChanged: (value) {
                  setState(() {
                    identityValue = value;
                  });
                }),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                maxLength: 15,
                controller: identificationController,
                //keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Identification',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your identification number.';
                  }

                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white // Set the button color to green
                  ),
              onPressed: () async {
                if (identityValue == 0) {
                  identityValueDescription = 'idnumber';
                  sendOtp(identityValueDescription,
                      identificationController.value.text);
                } else {
                  identityValueDescription = 'passport';
                  sendOtp(identityValueDescription,
                      identificationController.value.text);
                }
              },
              child: const Text('GET USERNAME'),
            ),
          ],
        ),
      ),
    );
  }
}

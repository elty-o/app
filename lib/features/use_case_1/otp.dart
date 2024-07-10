import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/use_case_1/login.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String otp = '';
  String textResponse = '';

  String returnVal = '';
  Future<void> sendOtp() async {
    final String pathParams =
        '/${GlobalVariables().userData["cellHome"]}/${GlobalVariables().userData["email"]}';

    final String endPoint = GlobalVariables().sendOtpEndPoint;
    final String resourceURL = '$endPoint$pathParams';

    debugPrint(resourceURL);

    final response = await http.get(Uri.parse(resourceURL));

    if (response.statusCode == 200) {
      if (!response.body.contains('fail')) {
        debugPrint('Sent OTP Method: Response Body: ${response.body}');
        otp = response.body;
      } else {
        debugPrint('Error: ${response.body}');
      }
    } else {
      debugPrint('System error: ${response.body}');
    }
  }

  Future<void> registrationService() async {
    if (otp.isEmpty) {
      //toaster('Please request an OTP');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please request an OTP.'),
        ),
      );
      return;
    }

    if (!otp.contains(optController.value.text)) {
      //toaster('Invalid OTP');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP.'),
        ),
      );
      debugPrint('Invalid OTP: ${optController.value.text} <> $otp');
      return;
    }

    final Map<String, String> userData = GlobalVariables().userData;
    String passport = userData['passport'].toString();
    if (passport.isNotEmpty) {
      passport = '''"passport": "${userData['name']}" ,''';
    }

    debugPrint(
        'Register User Method: Url = ${GlobalVariables().registerUserEndPoint}');

    debugPrint(
        '${GlobalVariables().userData['name']} ---------------------------------------- Name');

// https://beta.eservices.gov.za/rest/members/updatepassword/
    final response = await http.post(
        Uri.parse(GlobalVariables()
            .registerUserEndPoint), //TODO: GlobalVariables().phpUserRegistration <-- ADD THIS AGAIN 20240703 GlobalVariables().registerUserEndPoint <---- Directly from service
        headers: {'Content-Type': 'application/json'},
        /*
        TODO: THIS NEEDS TO BE ADDED 20240703
        body: jsonEncode({
          "name": GlobalVariables().userData['name'],
          "secondName": GlobalVariables().userData['secondName'],
          "thirdName": GlobalVariables().userData['thirdName'],
          "surname": GlobalVariables().userData['surname'],
          "idNumber": GlobalVariables().userData['idNumber'],
          "passport": GlobalVariables().userData['passport'],
          "password": GlobalVariables().userData['password'],
          "email": GlobalVariables().userData['email'],
          "cellHome": GlobalVariables().userData['cellHome'],
          "cellWork": GlobalVariables().userData['cellWork'],
          "emailHome": GlobalVariables().userData['emailHome'],
          "emailWork": GlobalVariables().userData['emailWork'],
          "landlineHome": GlobalVariables().userData['landlineHome'],
          "landlineWork": GlobalVariables().userData['landlineWork']
        })*/
        body: jsonEncode({
          "user": {
            "name": "${GlobalVariables().userData['name']}",
            "secondName": "${GlobalVariables().userData['secondName']}",
            "thirdName": "${GlobalVariables().userData['thirdName']}",
            "surname": "${GlobalVariables().userData['surname']}",
            "idNumber": "${GlobalVariables().userData['idNumber']}",
            "passport": "${GlobalVariables().userData['passport']}",
            "password": "${GlobalVariables().userData['password']}",
            "email": "${GlobalVariables().userData['email']}"
          },
          "address": {},
          "contact": {
            "cellHome": "${GlobalVariables().userData['cellHome']}",
            "cellWork": "${GlobalVariables().userData['cellWork']}",
            "emailHome": "${GlobalVariables().userData['emailHome']}",
            "emailWork": "${GlobalVariables().userData['emailWork']}",
            "landlineHome": "${GlobalVariables().userData['landlineHome']}",
            "landlineWork": "${GlobalVariables().userData['landlineWork']}"
          }
        }));

    debugPrint(
        '------------------------------------------------ ${response.statusCode} THIS IS THE JSON OUTPUT');

    debugPrint('Register User Method: Response Body = ${response.body}');
    debugPrint('Register User Method: Response Code = ${response.statusCode}');

    textResponse = response.body;
    debugPrint('${response.body} move user');
    if (response.statusCode == 200) {
      navigator();
    } else {
      debugPrint('System error: ${response.body} ${response.statusCode}');
    }
  }

  void fetchData() {}

  void navigator() {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text('Profile has been registered successfully.'),
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Future.delayed(snackBar.duration, () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  final TextEditingController optController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    sendOtp();
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
      body: Center(
        child: Column(
          children: [
            Container(
              width: 800,
              height: 70,
              color: Colors.green,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('USER VERIFICATION',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gill')),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: optController,
                decoration: const InputDecoration(
                    labelText: 'Enter OTP', border: OutlineInputBorder()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      debugPrint('cancel');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor:
                            Colors.white // Set the button color to green
                        ),
                    child: const Text('CANCEL')),
                ElevatedButton(
                    onPressed: () {
                      debugPrint('submit');
                      registrationService();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor:
                            Colors.white // Set the button color to green
                        ),
                    child: const Text('SUBMIT')),
                ElevatedButton(
                    onPressed: () {
                      debugPrint('new opt');
                      sendOtp();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor:
                            Colors.white // Set the button color to green
                        ),
                    child: const Text('RESEND OTP')) //NEW OTP
              ],
            )
          ],
        ),
      ),
    );
  }
}

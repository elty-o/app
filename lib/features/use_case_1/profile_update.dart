import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController firstName =
      TextEditingController(text: GlobalVariables().username);
  TextEditingController secondName =
      TextEditingController(text: GlobalVariables().secondName);
  TextEditingController thirdName =
      TextEditingController(text: GlobalVariables().thirdName);
  TextEditingController surname =
      TextEditingController(text: GlobalVariables().userSurname);
  // TextEditingController location =
  //     TextEditingController(text: GlobalVariables().location);
  TextEditingController cellphoneNumber =
      TextEditingController(text: GlobalVariables().cellphoneNumber);
  TextEditingController email =
      TextEditingController(text: GlobalVariables().userEmail);
  //bool loggedIn = GlobalVariables().loggedIn;

  Future<void> updateUserProfile(
      String firstName,
      String secondName,
      String thirdName,
      String surname,
      //String location,
      String cellphoneNumber,
      String email) async {
    final response =
        await http.post(Uri.parse(GlobalVariables().updateUserProfile),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "name": "$firstName",
              "secondName": "$secondName",
              "thirdName": "$thirdName",
              "surname": "$surname",
              "idNumber": "${GlobalVariables().idNumber}",
              "passport": "${GlobalVariables().passpord}",
              "phoneNumber": "$cellphoneNumber",
              "email": "$email",
            }));

    Map<String, dynamic> getResponse = jsonDecode(response.body);

    debugPrint(response.body);

    //if (response.statusCode == GlobalVariables().responseCode) {
    if (response.statusCode == 200) {
      debugPrint("THIS THE USER ID: ${getResponse['userId']}");
      GlobalVariables().username = getResponse['name'];
      GlobalVariables().secondName = getResponse['secondName'];
      GlobalVariables().thirdName = getResponse['thirdName'];
      GlobalVariables().userSurname = getResponse['surname'];
      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Profile has been updated successfully.'),
        duration: Duration(seconds: 3),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Future.delayed(snackBar.duration, () {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().noDrawerAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 800,
              height: 50,
              color: Colors.green,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('UPDATE PROFILE',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gill')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GlobalVariables().idNumber != ''
                  ? Text(
                      'ID Number: ${GlobalVariables().idNumber}',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Passport Number: ${GlobalVariables().passpord}',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: firstName,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        // errorText: _usernameController.text.length > 0
                        //     ? null
                        //     : 'Password is required',

                        hoverColor: Colors.green,
                        labelText: 'First Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: secondName,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        // errorText: _usernameController.text.length > 0
                        //     ? null
                        //     : 'Password is required',

                        hoverColor: Colors.green,
                        labelText: 'Second Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: thirdName,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        // errorText: _usernameController.text.length > 0
                        //     ? null
                        //     : 'Password is required',

                        hoverColor: Colors.green,
                        labelText: 'Third Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: surname,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        // errorText: _usernameController.text.length > 0
                        //     ? null
                        //     : 'Password is required',

                        hoverColor: Colors.green,
                        labelText: 'Surname',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  //LOCATION Removed
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     controller: location,
                  //     cursorColor: Colors.green,
                  //     decoration: InputDecoration(
                  //       // errorText: _usernameController.text.length > 0
                  //       //     ? null
                  //       //     : 'Password is required',

                  //       hoverColor: Colors.green,
                  //       labelText: 'Location',
                  //       labelStyle: TextStyle(color: Colors.grey),
                  //       focusColor: Colors.green,
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.green),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: cellphoneNumber,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        // errorText: _usernameController.text.length > 0
                        //     ? null
                        //     : 'Password is required',

                        hoverColor: Colors.green,
                        labelText: 'Cellphone Number',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: email,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        // errorText: _usernameController.text.length > 0
                        //     ? null
                        //     : 'Password is required',

                        hoverColor: Colors.green,
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor:
                                  Colors.white // Set the button color to green
                              ),
                          onPressed: () {
                            updateUserProfile(
                                firstName.text,
                                secondName.text,
                                thirdName.text,
                                surname.text,
                                cellphoneNumber.text,
                                email.text);
                          },
                          child: const Text('UPDATE'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor:
                                  Colors.white // Set the button color to green
                              ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL'),
                        ),
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
}

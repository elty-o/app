import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/use_case_1/login.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/core/globals.dart';

class PasswordUpdate extends StatefulWidget {
  const PasswordUpdate({super.key});

  @override
  State<PasswordUpdate> createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  //Password Validation
  bool passwordStrengthSecure = false;
  String password = '';
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

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  Future<void> updateUserPassword(
    String currentPassword,
    String newPassword,
  ) async {
    final response =
        await http.post(Uri.parse(GlobalVariables().changeUserPassword),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "email": "${GlobalVariables().userEmail}",
              "oldpassword": "$currentPassword",
              "newpassword": "$newPassword"
            }));

    Map<String, dynamic> getResponse = jsonDecode(response.body);

    if (response.statusCode == GlobalVariables().responseCode) {
      if (response.body.contains('success')) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
        // Elton -> New message added: 02/07/2024
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password updated successfully.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${getResponse['error']}'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${getResponse['error']}'),
        ),
      );
    }
  }

  bool obscureTextController = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().secondaryAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: 800,
            height: 50,
            color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('UPDATE PASSWORD',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gill')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: currentPasswordController,
              obscureText: obscureTextController,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureTextController = !obscureTextController;
                      });
                    },
                    child: obscureTextController
                        ? Icon(Icons.visibility_off_outlined)
                        : Icon(Icons.visibility_outlined)),
                // errorText: _usernameController.text.length > 0
                //     ? null
                //     : 'Password is required',

                hoverColor: Colors.green,
                labelText: 'Current Password',
                labelStyle: TextStyle(color: Colors.grey),
                focusColor: Colors.green,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: newPasswordController,
              obscureText: true,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                // errorText: _usernameController.text.length > 0
                //     ? null
                //     : 'Password is required',

                hoverColor: Colors.green,
                labelText: 'New Password',
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
              controller: confirmNewPasswordController,
              obscureText: true,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                // errorText: _usernameController.text.length > 0
                //     ? null
                //     : 'Password is required',

                hoverColor: Colors.green,
                labelText: 'Confirm Password',
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
                    if (newPasswordController.value.text ==
                        confirmNewPasswordController.value.text) {
                      passwordStrengthSecure =
                          validatePassword(newPasswordController.value.text);
                      if (passwordStrengthSecure) {
                        updateUserPassword(
                          currentPasswordController.value.text,
                          newPasswordController.value.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Password must be alphanumeric, contain at least one uppercase, lowercase and special character'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Passwords does not match.}'),
                        ),
                      );
                    }
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
      )),
    );
  }
}

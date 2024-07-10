import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LoginModal extends StatefulWidget {
  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String url = GlobalVariables()
      .globalUrl; //'${GlobalVariables.server}/cips/epermit?id=';

  bool obscureTextController = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.authentication),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Semantics(
                  label: AppLocalizations.of(context)!.enter_username,
                  child: TextField(
                    controller: _usernameController,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
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
                      hoverColor: Colors.green,
                      labelText: AppLocalizations.of(context)!.password,
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
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_usernameController.value.text.isNotEmpty ||
                              _passwordController.value.text.isNotEmpty) {
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
                        },
                        child: Text(AppLocalizations.of(context)!.loginButton),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.cancelButton),
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
  }

  void userValidationViaWildFly(String username, String password) async {
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
          Navigator.popAndPushNamed(context, '/webpage', arguments: {
            'url': '$url${GlobalVariables().token}',
            'name': AppLocalizations.of(context)!.land_services
          });
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
}

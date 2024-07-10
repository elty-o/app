import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;

class UpdateUsername extends StatefulWidget {
  const UpdateUsername({super.key});

  @override
  State<UpdateUsername> createState() => _UpdateUsernameState();
}

class _UpdateUsernameState extends State<UpdateUsername> {
  String username = '';
  TextEditingController newUsernameController = TextEditingController();
  TextEditingController confirmNewUsernameController = TextEditingController();

  Future<void> updateUsername(String oldEmail, String newEmail) async {
    final response = await http.post(
        Uri.parse('${GlobalVariables().updateUsernameEndPoint}'),
        headers: {
          'Content-Type': '	application/json',
        },
        body: jsonEncode({"oldemail": "$oldEmail", "newemail": "$newEmail"}));

    Map<String, dynamic> fromUpdateUsernameAPI = jsonDecode(response.body);
    debugPrint('$oldEmail---------STATUS CODE: ${response.statusCode}');
    if (response.statusCode == 200) {
      if (fromUpdateUsernameAPI['success'] == 'successfull') {
        GlobalVariables().userEmail = newEmail;

        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Username has been updated successfully.'),
          duration: Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Future.delayed(snackBar.duration, () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${fromUpdateUsernameAPI['error']}'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username could not be updated.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //final String id = args['id'];
    final String username = args['username'];

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
        Text(
          'Your current username:\n$username',
          style: TextStyle(fontFamily: 'Gill', fontSize: 20),
        ),
        TextFormField(
          controller: newUsernameController,
          //keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'New Username',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your username.';
            }

            return null;
          },
        ),
        TextFormField(
          controller: confirmNewUsernameController,
          //keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Confirm Username',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please confirm your username.';
            }

            return null;
          },
        ),
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white // Set the button color to green
                  ),
              onPressed: () async {
                // if (identityValue == 0) {
                //   identityValueDescription = 'idnumber';
                // } else {
                //   identityValueDescription = 'passport';
                // }

                if (newUsernameController.value.text ==
                    confirmNewUsernameController.value.text) {
                  await updateUsername(
                      username, newUsernameController.value.text);
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil('/login', (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usernames do not match.'),
                    ),
                  );
                }
              },
              child: const Text('UPDATE'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white // Set the button color to green
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
        )
      ]),
    );
  }
}

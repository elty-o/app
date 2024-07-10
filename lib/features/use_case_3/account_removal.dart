import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_application_1/core/globals.dart';

class AccountRemoval extends StatefulWidget {
  const AccountRemoval({super.key});

  @override
  State<AccountRemoval> createState() => _AccountRemovalState();
}

class _AccountRemovalState extends State<AccountRemoval> {
  bool isChecked = false;
  Future<void> deleteAccount(int userStatus) async {
    final response;
    final removed = 2;
    final suspended = 3;

    if (userStatus == 1) {
      response =
          await http.post(Uri.parse('${GlobalVariables().deleteUserAccount}'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "userId":
                    "${GlobalVariables().userId}", //${GlobalVariables().userId}
                "userStatusId": "$suspended"
              })); //
    } else {
      response =
          await http.post(Uri.parse('${GlobalVariables().deleteUserAccount}'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "userId":
                    "${GlobalVariables().userId}", //${GlobalVariables().userId}
                "userStatusId": "$removed"
              })); //
    }

    Map<String, dynamic> responseBack = jsonDecode(response.body);
    //debugPrint('RESPONSE FROM SERVER: ${responseBack['message']}');
    if (response.statusCode == 200) {
      GlobalVariables().loggedIn = false;
      await Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${responseBack['message']}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              AppLocalizations.of(context)!.deleteAccountFailedServerMessage),
        ),
      );
    }
  }

  int? _selectedValue;

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
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.removeAccount,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gill')),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.suspensionMessage),
                ),
                RadioListTile<int>(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.red;
                    }
                    return Colors.red;
                  }),
                  title: Text(AppLocalizations.of(context)!.accountSuspension),
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.removalMessage),
                ),
                RadioListTile<int>(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.red;
                    }
                    return Colors.red;
                  }),
                  title: Text(AppLocalizations.of(context)!.accountRemoval),
                  value: 2,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.consentMessage),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.red,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.red;
                      }
                      return Colors.red;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.consentAcknowledge,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors
                                      .white // Set the button color to green
                                  ),
                              onPressed: isChecked && _selectedValue != null
                                  ? () {
                                      deleteAccount(_selectedValue ?? 0);
                                    }
                                  : null,
                              child:
                                  Text(AppLocalizations.of(context)!.proceed)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors
                                      .white // Set the button color to green
                                  ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.cancelButton)),
                        )
                      ],
                    )),
              ])
        ],
      )),
    );
  }
}

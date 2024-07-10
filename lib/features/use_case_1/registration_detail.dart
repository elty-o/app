//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
//import 'package:flutter_application_1/features/login.dart';
import 'package:flutter_application_1/features/use_case_1/otp.dart';
import 'package:http/http.dart' as http;
//import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_application_1/core/globals.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_application_1/core/idverification.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class RegistrationDetail extends StatefulWidget {
  const RegistrationDetail({super.key});

  @override
  State<RegistrationDetail> createState() => _RegistrationDetailState();
}

class _RegistrationDetailState extends State<RegistrationDetail> {
  // String registerUser =
  //     'http://beta.eservices.gov.za/tonkana/rest/users/adduser';
  // String registerUser = 'http://192.168.8.100/tonkana/registrationservice.php';
  // String validateNewUserEndPoint =
  //     'http://192.168.8.100:80/tonkana/opt/validatenewuser.php';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController thirdNameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController passportNumberController =
      TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController confirmCellphoneController =
      TextEditingController();
  final TextEditingController landLineController = TextEditingController();
  final TextEditingController confirmLandLineController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController suburbController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController verificationController = TextEditingController();

  bool validIdNumber = false;

  //TOASTERS HAS BEEN REPLACED BY SCAFFOLD MESSAGES
  // void toaster(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     textColor: Colors.green,
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  // }

  //Validate user
  void submitForValidation() {
    if (ValidateID().rsaIDNumberValid(idNumberController.value.text)) {
      validateNewUser();
    } else {
      //toaster('ID Number invalid');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID Number invalid.'),
        ),
      );
    }
  }

  Future<void> validateNewUser() async {
    GlobalVariables().userData = {
      "name": firstNameController.value.text,
      "secondName": secondNameController.value.text,
      "thirdName": thirdNameController.value.text,
      "surname": surnameController.value.text,
      "idNumber": idNumberController.value.text,
      "passport": passportNumberController.value.text,
      "password": passwordController.value.text,
      "email": emailController.value.text,
      "cellHome": cellphoneController.value.text,
      "cellWork": cellphoneController.value.text,
      "emailHome": emailController.value.text,
      "emailWork": emailController.value.text,
      "landlineHome": landLineController.value.text,
      "landlineWork": landLineController.value.text
    };

    debugPrint('his is before response from update password');

    final Map<String, String> userData = GlobalVariables().userData;
    final String pathParams =
        '/${userData["cellHome"]}/${userData["email"]}/${userData["idNumber"]}';
    final String endPoint = GlobalVariables()
        .validateNewUserEndPoint; //'$server/tonkana/rest/users/adduser';
    final String resourceURL = '$endPoint$pathParams';

    debugPrint('IN BEFORE GET ${userData['email']}');

    debugPrint(resourceURL);

    final response = await http.get(Uri.parse(resourceURL));

    if (response.statusCode == 200) {
      if (response.body.contains('success')) {
        navigator();
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

  void navigator() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Otp()));
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

  // void navigator() {
  //   Navigator.pushNamed(
  //       context, '/opt', arguments: {

  //       });
  // }

  bool isValidEmail = true;

  String errorMessage = '';
  String idErrorMessage = '';
  String firstNameError = '';
  String surnameError = '';

  void validateEmail() {
    setState(() {
      isValidEmail = EmailValidator.validate(emailController.text);
    });
  }

  bool obscureTextController = true;

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
        child: Column(children: [
          Container(
            width: 800,
            height: 50,
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(AppLocalizations.of(context)!.registrationTitle,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gill')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  maxLength: 50,
                  controller: firstNameController,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    errorText: errorMessage,
                    labelText: AppLocalizations.of(context)!.firstName,
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 50,
                  controller: secondNameController,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.secondName,
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 50,
                  controller: thirdNameController,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.thirdName,
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 50,
                  controller: surnameController,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.surname,
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    errorText: errorMessage,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 13,
                  controller: idNumberController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.green,
                  // onChanged: (value) {
                  //   validIdNumber = ValidateID().rsaIDNumberValid(value);
                  //   if (!validIdNumber) {
                  //     toaster('ID Number is invalid');
                  //   }
                  // },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.idNumber,
                    labelStyle: const TextStyle(color: Colors.grey),
                    errorText: errorMessage,
                    focusColor: Colors.green,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 15,
                  controller: passportNumberController,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.passportNumber,
                    errorText: errorMessage,
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  controller: cellphoneController,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.cellphone,
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // TextField(
                //   controller: confirmCellphoneController,
                //   cursorColor: Colors.green,
                //   decoration: const InputDecoration(
                //     labelText: 'Confirm Cellphone',
                //     labelStyle: TextStyle(color: Colors.grey),
                //     focusColor: Colors.green,
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.green),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                TextField(
                  maxLength: 10,
                  controller: landLineController,
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.landline,
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // TextField(
                //   controller: confirmLandLineController,
                //   cursorColor: Colors.green,
                //   decoration: const InputDecoration(
                //     labelText: 'Confirm Landline',
                //     labelStyle: TextStyle(color: Colors.grey),
                //     focusColor: Colors.green,
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.green),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                TextField(
                  maxLength: 100,
                  controller: emailController,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    helperText: 'example@example.com',
                    labelText: AppLocalizations.of(context)!.email,
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    errorText:
                        isValidEmail ? null : 'Enter valid email address',
                  ),
                  onChanged: (value) {
                    validateEmail();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // TextField(
                //   controller: confirmEmailController,
                //   cursorColor: Colors.green,
                //   decoration: const InputDecoration(
                //     labelText: 'Confirm Email',
                //     labelStyle: TextStyle(color: Colors.grey),
                //     focusColor: Colors.green,
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.green),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                TextField(
                  maxLength: 50,
                  controller: suburbController,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.suburb,
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
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
                    labelText: AppLocalizations.of(context)!.password,
                    // helperText:
                    //   AppLocalizations.of(context)!.passwordRequirements,
                    //Append variable on value change: Weak/Strong
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: obscureTextController,
                ),
                SizedBox(
                    height:
                        8), // Space between the TextField and the helper text
                Text(
                  AppLocalizations.of(context)!.passwordRequirements,
                  softWrap: true,
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: confirmPasswordController,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.confirmPasswordFieldLabel,
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor:
                        Colors.white // Set the button color to green
                    ),
                onPressed: () {
                  if (firstNameController.value.text == '' ||
                      firstNameController.value.text.isEmpty) {
                    firstNameError = 'Required';
                  }

                  if (idNumberController.value.text == '' ||
                      idNumberController.value.text.length < 13 ||
                      idNumberController.value.text.length > 13 ||
                      idNumberController.value.text.isEmpty ||
                      idNumberController.value.text.length < 13 ||
                      idNumberController.value.text.length > 13) {
                    idErrorMessage = 'Required';
                  }
                  if (passwordController.value.text != '' &&
                      passwordController.text ==
                          confirmPasswordController.text) {
                    passwordStrengthSecure =
                        validatePassword(passwordController.value.text);
                    if (passwordStrengthSecure) {
                      submitForValidation();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Password must be alphanumeric, contain at least one uppercase, lowercase and special character'),
                        ),
                      );
                    }
                    ///////////////////////////////////////////////////////////////////////////////////////////////////
                    // if (passwordController.text.length >= 8) {
                    //   //validatePassword(passwordController.value.text);
                    //   submitForValidation();
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text(
                    //           'Password must be greater than 7 characters'),
                    //     ),
                    //   );
                    // }

                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    //debugPrint(firstNameController.value.text);
                    //register();
                    //validateNewUser();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Passwords does not match'),
                      ),
                    );
                    // debugPrint(
                    //     'No Valid one 3333333333333333333333333333333333333333333333333333333333333333333');
                    //Navigator.pushNamed(context, '/opt');
                  }
                },
                child: Text(AppLocalizations.of(context)!.registerButton)),
          )
        ]),
      ),
    );
  }
}

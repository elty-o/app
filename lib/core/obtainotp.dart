import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:http/http.dart' as http;

class GetAnOtp {
  Future<void> sendOtp(String email, String cellphone) async {
    debugPrint('-------------------------------- $email this is $cellphone');
    final String pathParams = '/$cellphone/$email';
    //Test Values
    //String pathParams = '/0722153138/e@e.c';

    final String endPoint = GlobalVariables().sendOtpEndPoint;
    final String resourceURL = '$endPoint$pathParams';

    debugPrint(resourceURL);

    final response = await http.get(Uri.parse(resourceURL));

    debugPrint('----------------------- ${response.statusCode}');

    if (response.statusCode == 200) {
      if (!response.body.contains('fail')) {
        //if (response.statusCode == 200) {
        // Handle the PHP file response if needed
        debugPrint('Sent OTP Method: Response Body: ${response.body}');

        // Decode the JSON string into a Map
        Map<String, dynamic> decodedJson = jsonDecode(response.body);

        // Extract values from the Map
        String otp = decodedJson['otp'];

        GlobalVariables().forgotPasswordOtp = otp;

        debugPrint('Extract OTP from JSON: $otp');
        //otp = response.body;
        // REMOVE Respons Body////////////////////////////////////////////////////////////////////////////////
        //toaster('OTP sent ${response.body}');
      } else {
        // Handle errors
        debugPrint('Error: ${response.body}');
        //toaster('OTP not sent, please re-sent');
      }
    } else {
      debugPrint('System error: ${response.body}');
    }
  }
}

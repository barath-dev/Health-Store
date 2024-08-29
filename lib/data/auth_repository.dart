import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hospital/core/utils/shared_pref.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.example.com';


class AuthRepository {
  static Future<bool> sendOTP(String mobileNumber, String countryCode) async {
    print('$mobileNumber $countryCode');
    print(countryCode.substring(1));
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'contactNumber': {
        'number': mobileNumber,
        'countryCode': countryCode.substring(1)
      }
    });
    //debugPrint('sendingotp');
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: headers,
        body: body,
      );
      //debugPrint(response.body);
      print('response');
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to send mobile number: ${e.toString()}');
    }
  }

  static Future<String> verifyOtp(
      String otp, number, String countryCode) async {
    // Verify OTP with the server
    final headers = {'Content-Type': 'application/json'};

    print(otp + ' ' + number + ' ' + countryCode);

    var body = jsonEncode({
      // "name": "Uday",
      "contactNumber": {
        "countryCode": countryCode.substring(1),
        "number": number
      },
      // "userId": "1212123432",
      "otp": otp
    });
    try {
      var response = await http
          .post(Uri.parse("$baseUrl/register/verify"),
              body: body, headers: headers)
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(
              'The connection has timed out, please try again.');
        },
      );

      var data = jsonDecode(response.body);

      debugPrint(data['statusCode'] == 200 ? 'Success' : 'Failed');

      if (data['statusCode'] == 200) {
        // Successful request

        await SharedPrefs.setAuthToken(data['authToken']);

        if (data['newUser']) {
          return "newUser";
        } else {
          return "oldUser";
        }
      } else {
        return "failed";
      }
    } catch (e) {
      throw Exception('Failed to verify mobile number: ${e.toString()}');
    }
  }

  // logout
  static Future<void> logout() async {
    await SharedPrefs.clearAuthToken();
  }
}

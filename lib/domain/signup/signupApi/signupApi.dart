import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/domain/signup/signupModel/signUpModel.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  Future<bool> register(SignUpModel user) async {
    bool isRegister = false;
    var url = baseUrl + registerUrl;
    var dio = HttpServices().getDioInstance();
    try {
      print('Sending registration request to: $url');
      print('Request data: ${user.toJson()}');

      Response response = await dio.post(
        url,
        data: user.toJson(),
      );
      print("Responsecode is ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Response data isss signUPAPi: ${response.data}");
        // fetch token from response
        var verifyTokenRegister = response.data['token'];
        print("verifyTokenRegister from response: $verifyTokenRegister");

        // Save the token using shared_preferences
        await saveToken(verifyTokenRegister);

        return true;
      } else {
        debugPrint("Received status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isRegister;
  }

  // getuser
  Future<bool> getUserFunction() async {
    bool isGetUser = false;
    Response response;
    var url = baseUrl + getUser;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        print("Response data isss signUPAPi: ${response.data}");
        return true;
      } else {
        debugPrint("Received status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isGetUser;
  }

  Future<void> saveToken(String token) async {
    // Get an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save the token to SharedPreferences
    await prefs.setString('token', token);
    print("saved randomtoken is $token");
  }
}

import 'package:dio/dio.dart';
import 'package:finalyear/domain/signin/signinApi/signinModel/login_model.dart';
import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// class LoginApi {
//   Future<bool> login(LoginModel user) async {
//     bool isLogin = false;
//     Response response;
//     var url = baseUrl + loginUrl;
//     var dio = HttpServices().getDioInstance();

//     try {
//       response = await dio.post(
//         url,
//         data: user.toJson(),
//       );
//       if (response.statusCode == 200) {
//         print("status code200");
//         print("Response data isss loginAPi: ${response.data}");

//         // LoginResponse loginResponse = LoginResponse.fromJson(response.data);

//         // String? token = loginResponse.jwtToken!.access;
//         // print("Token is $token");
//         // if (token != null) {
//         //   isLogin = true;
//         // }

//         return true;
//       } else {
//         debugPrint("Received status code: ${response.statusCode}");
//         debugPrint("Response data: ${response.data}");
//       }
//     } catch (e) {
//       debugPrint("Error: ${e.toString()}");
//     }

//     return isLogin;
//   }

import 'package:shared_preferences/shared_preferences.dart';

// class LoginApi {
//   Future<bool> login(LoginModel user) async {
//     bool isLogin = false;
//     var url = baseUrl + loginUrl;
//     var dio = HttpServices().getDioInstance();

//     try {
//       Response response = await dio.post(
//         url,
//         data: user.toJson(),
//       );

//       if (response.statusCode == 200) {
//         print("status code 200");
//         print("Response data from login API: ${response.data}");

//         print("Is stafff ${response.data['is_Staff']}");
//         // Parse response data as a Map
//         Map<String, dynamic> responseData = response.data;

//         // Check if 'success' key exists in the response data
//         if (responseData.containsKey('success')) {
//           // Access the value corresponding to the 'success' key
//           bool successValue = responseData['success'];

//           if (successValue) {
//             // If login is successful, extract the token
//             String? token = responseData['token'];
//             print("Token is $token");

//             if (token != null) {
//               // Save token using shared_preferences
//               await saveToken(token);
//               isLogin = true;
//             }
//           } else {
//             // If login is unsuccessful, print the error message
//             print("Login failed. Reason: ${responseData['message']}");
//           }
//         } else {
//           // Handle the case where 'success' key is missing in responseData
//           print("Response data does not contain 'success' key.");
//         }
//       } else {
//         print("Received status code: ${response.statusCode}");
//         print("Response data: ${response.data}");
//       }
//     } catch (e) {
//       print("Error: ${e.toString()}");
//     }

//     return isLogin;
//   }

class LoginApi {
  Future<Map<String, dynamic>> login(LoginModel user) async {
    Map<String, dynamic> loginResult = {};
    var url = baseUrl + loginUrl;
    var dio = HttpServices().getDioInstance();

    try {
      Response response = await dio.post(
        url,
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        print("status code 200");
        print("Response data from login API: ${response.data}");

// Extract data from the response
        Map<String, dynamic> responseData = response.data;
        Map<String, dynamic> userData =
            responseData['data']; // Access the 'data' object

        int? userId = userData['id'];
        String? userName = userData['name'];
        String? userEmail = userData['email'];
        String? location = userData['location'];
        String? phone = userData['phone'];
        String? userToken = responseData['token'];
        int? wardno = userData['wardno'];

// Save user details to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('user_id', userId ?? 0);
        prefs.setString('user_name', userName ?? '');
        prefs.setString('user_email', userEmail ?? '');
        prefs.setString('user_token', userToken ?? '');
        prefs.setString('location', location ?? '');
        prefs.setString('phone', phone ?? '');
        prefs.setInt('wardno', wardno ?? 0);

        print(
            'User details saved to SharedPreferences $userId, $userName, $userEmail, $location, $phone, $userToken');

        if (responseData.containsKey('data')) { 
          // Access the value corresponding to the 'data' key
          Map<String, dynamic> data = responseData['data'];

          // Access the values for 'is_Staff' and 'is_Admin' directly
          loginResult['is_Staff'] = data['is_Staff'] == 1 ? true : false;
          loginResult['is_Admin'] = data['is_Admin'] == 1 ? true : false;
          loginResult['is_Verified'] = data['is_Verified'] == 1 ? true : false;

// Check if 'role' key exists in the 'data' map
          if (data.containsKey('role')) {
            // Access the value corresponding to the 'role' key
            loginResult['role'] = data['role'];
          }
          // Set the success flag to true since the request was successful
          loginResult['success'] = true;
        } else {
          print("response does not contain 'data'");
        }
      } else {
        print("Received status code: ${response.statusCode}");
        print("Response data: ${response.data}");
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }

    return loginResult;
  }

// thik cha yo

// class LoginApi {
//   Future<Map<String, bool>> login(LoginModel user) async {
//     Map<String, bool> loginResult = {
//       'success': false,
//       'is_Staff': false,
//       'is_Admin': false,
//     };
//     var url = baseUrl + loginUrl;
//     var dio = HttpServices().getDioInstance();

//     try {
//       Response response = await dio.post(
//         url,
//         data: user.toJson(),
//       );

//       if (response.statusCode == 200) {
//         print("status code 200");
//         print("Response data from login API: ${response.data}");

//         // Parse response data as a Map
//         Map<String, dynamic> responseData = response.data;

//         // Check if 'success' key exists in the response data
//         if (responseData.containsKey('success')) {
//           // Access the value corresponding to the 'success' key
//           bool successValue = responseData['success'];
//           print("bool successValue $successValue");

//           if (successValue) {
//             // If login is successful, extract the token
//             String? token = responseData['token'];
//             print("Token is $token");

//             if (token != null) {
//               // Save token using shared_preferences
//               await saveToken(token);
//               loginResult['success'] = true;
//             }
//           } else {
//             // If login is unsuccessful, print the error message
//             print("Login failed. Reason: ${responseData['message']}");
//           }

//           // Check if 'data' key exists in the response data
//           if (responseData.containsKey('data')) {
//             // Access the value corresponding to the 'data' key
//             Map<String, dynamic> data = responseData['data'];

//             // Check if 'is_Staff' key exists in the 'data' map
//             if (data.containsKey('is_Staff')) {
//               // Access the value corresponding to the 'is_Staff' key
//               print("response contains 'is_Staff'");
//               bool isStaff = data['is_Staff'] == 1;
//               loginResult['is_Staff'] = isStaff;
//               print("isStaff bool ${loginResult['is_Staff']}");
//             } else {
//               // Set default value for 'is_Staff' if key is not present
//               print("response does not contain 'is_Staff'");
//               loginResult['is_Staff'] = false;
//             }
//           } else {
//             // Set default value for 'is_Staff' if 'data' key is not present
//             print("response does not contain 'data'");
//             loginResult['is_Staff'] = false;
//           }

//           // Check if 'data' key exists in the response data
//           if (responseData.containsKey('data')) {
//             // Access the value corresponding to the 'data' key
//             Map<String, dynamic> data = responseData['data'];

//             // Check if 'is_Admin' key exists in the 'data' map
//             if (data.containsKey('is_Admin')) {
//               // Access the value corresponding to the 'is_Admin' key
//               print("response contains 'is_Admin'");
//               bool isAdmin = data['is_Admin'] == 1;
//               loginResult['is_Admin'] = isAdmin;
//               print("isAdmin bool ${loginResult['is_Admin']}");
//             } else {
//               // Set default value for 'is_Admin' if key is not present
//               print("response does not contain 'isAdmin'");
//               loginResult['is_Admin'] = false;
//             }
//           } else {
//             // Set default value for 'is_Admin' if 'data' key is not present
//             print("response does not contain 'data'");
//             loginResult['is_Admin'] = false;
//           }
//         } else {
//           // Handle the case where 'success' key is missing in responseData
//           print("Response data does not contain 'success' key.");
//         }
//       } else {
//         print("Received status code: ${response.statusCode}");
//         print("Response data: ${response.data}");
//       }
//     } catch (e) {
//       print("Error: ${e.toString()}");
//     }

//     return loginResult;
//   }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token saved successfully: $token');
  }

  Future<bool> forgotPassword(String email) async {
    bool isForgot = false;
    Response response;
    var url = baseUrl + forgotPasswordUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: {"email": email},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint(
            "Received status code forgotpassword: ${response.statusCode}");
        debugPrint("Response data forgotpassword: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isForgot;
  }
}

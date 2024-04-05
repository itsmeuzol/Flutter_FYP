import 'package:finalyear/domain/signin/signinApi/signinApi.dart';
import 'package:finalyear/domain/signin/signinApi/signinModel/login_model.dart';

// class LoginRepository {
//   Future<bool> login(LoginModel user) async {
//     return await LoginApi().login(user);
//   }

// class LoginRepository {
//   Future<bool> login(LoginModel user) async {
//     // Call the login method from LoginApi
//     Map<String, dynamic> loginResult = await LoginApi().login(user);

//     // Extract the success value from the login result
//     // bool isLoginSuccessful = loginResult['success'] ?? false;

//     return loginResult;
//   }

//   Future<bool> forgotPassword(String email) async {
//     return await LoginApi().forgotPassword(email);
//   }
// }

class LoginRepository {
  Future<Map<String, dynamic>> login(LoginModel user) async {
    // Call the login method from LoginApi
    Map<String, dynamic> loginResult = await LoginApi().login(user);

    return loginResult;
  }

  Future<bool> forgotPassword(String email) async {
    return await LoginApi().forgotPassword(email);
  }
}

import 'dart:convert';

import 'package:finalyear/presentation/screens/login/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:finalyear/utils/urls.dart';

class VerifyMail extends StatefulWidget {
  final String registeredVerifyToken;

  const VerifyMail({Key? key, required this.registeredVerifyToken})
      : super(key: key);

  @override
  State<VerifyMail> createState() => _VerifyMailState();
}

class _VerifyMailState extends State<VerifyMail> {
  @override
  void initState() {
    super.initState();
    verifyEmail();
  }

  Future<void> verifyEmail() async {
    String? registeredVerifyToken = widget.registeredVerifyToken;

    if (registeredVerifyToken == null) {
      // Token is not available, handle accordingly
      print("Token not found in SharedPreferences");
      return;
    }

    final response = await http.get(
        // Uri.parse(
        //   'http://192.168.1.74:5000/mail-verification/?token=$registeredVerifyToken')

        Uri.parse(baseUrl + verifyMailUrl + 'token=$registeredVerifyToken'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      } else {
        print("Mail verification failed");
      }
    } else {
      // Handle HTTP request failure
      print("Failed to verify email: ${response.statusCode}");
      // Show an error message or retry verification
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email,
                size: 80,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'Please check your email and verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

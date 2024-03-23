import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:finalyear/components/constants.dart';
import 'package:finalyear/domain/signin/signinApi/signinRepository/login_repository.dart';
import 'package:finalyear/presentation/screens/login/signin_page.dart';
import 'package:finalyear/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:motion_toast/motion_toast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // dropdown value
  String dropdownValue = 'en';

  bool validEmail = false;
  bool validPassword = false;

  bool hasShownError = true;
  bool isSuccess = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final textControllerEmail = TextEditingController();

  _forgotPassword() async {
    try {
      LoginRepository loginRepository = LoginRepository();
      bool isForgot =
          await loginRepository.forgotPassword(textControllerEmail.text);

      if (isForgot) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return SignInPage();
        }));
      } else {
        MotionToast.error(
                height: 50.h,
                animationDuration: const Duration(milliseconds: 300),
                description: const Text("Please provide a valid email"))
            .show(context);
      }
    } catch (e) {
      MotionToast.error(
        height: 50.h,
        animationDuration: const Duration(milliseconds: 300),
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  void languageDropdownChanged(String? value) {
    if (value is String) {
      setState(() {
        dropdownValue = value;
      });
    }
  }

  // Future<void> _forgotPassword() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   final String email = textControllerEmail.text;

  //   final Uri url = Uri.parse('http://192.168.1.74:5000/api/forget-password/');
  //   final Map<String, String> body = {'email': email};

  //   try {
  //     final http.Response response = await http.post(
  //       url,
  //       body: body,
  //     );

  //     if (response.statusCode == 200) {
  //       // Password reset email sent successfully
  //       // You can navigate to another screen or show a success message
  //       print('Password reset email sent successfully');
  //     } else {
  //       // Handle other status codes (e.g., 400 for bad request)
  //       print('Errorelse: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     // Handle any errors that occur during the HTTP request
  //     print('Errocatchr: $error');
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/arrow_left.svg',
                            width: 15.w,
                            height: 15.h,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text("Forgot Password",
                    style: kHeadline.copyWith(fontSize: 20.sp)),
                SizedBox(
                  height: 20.h,
                ),
                //sign in with facebook rounded button
                Icon(
                  Icons.lock_outline,
                  color: Colors.green,
                  size: 100.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text("Did you forgot your password?", style: subhead),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Enter the email address associated with your account and we will send you a link to reset your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                //email text field with svg icon and controller
                InputField(
                  hintText: "Email",
                  icon: validEmail
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : SvgPicture.asset(
                          color: Colors.green,
                          "assets/icons/email.svg",
                          width: 20.w,
                          height: 20.h,
                        ),
                  controller: textControllerEmail,
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!isLoading) {
                      setState(() {
                        isLoading = true;
                      });

                      if (_formKey.currentState!.validate()) {
                        _forgotPassword();
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                      }
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size.fromHeight(20.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Submit",
                              style: kBodyText,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 20.w),
                            SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: Semantics(
                                label: "Loading",
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2.sp),
                          textAlign: TextAlign.center,
                        ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  String? validateEmail(String? value) {
    String regexEmailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(regexEmailPattern);
    if (!regex.hasMatch(value!)) {
      validEmail = false;
      return "Please enter a valid email";
    } else {
      validEmail = true;
      return null;
    }
  }
}

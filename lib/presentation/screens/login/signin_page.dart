import 'package:finalyear/domain/signin/signinApi/signinModel/login_model.dart';
import 'package:finalyear/domain/signin/signinApi/signinRepository/login_repository.dart';
import 'package:finalyear/presentation/screens/forgotPassword/forgotPassword.dart';
import 'package:finalyear/presentation/screens/admin_main/adminHomepage/adminHomepage.dart';
import 'package:finalyear/presentation/screens/signup/signup.dart'; // Import the SignUp page
import 'package:finalyear/presentation/screens/staff_main/staffHomepage/staffHomepage.dart';
import 'package:finalyear/presentation/screens/user_main/userHomepage/userHomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/constants.dart';
import '../../../widgets/my_text_field.dart';
import '../../../widgets/my_password_field.dart';
import '../../../widgets/my_text_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');
    print("Auth login token is $token");

    if (token != null && token.isNotEmpty) {
      _navigateToScreen(true);
    }
  }

  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const AdminHomePage())); //change garnu parxa
    } else {
      MotionToast.error(
          animationDuration: const Duration(milliseconds: 200),
          description: const Text(
            "Either email or password is wrong",
            style: TextStyle(color: Colors.red),
          )).show(context);
    }
  }

  _loginUser() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // String? token = sharedPreferences.getString('token');
    // print("Auth login token is $token");
    try {
      print("emailcont is ${_emailController.text}");
      print("passcont is ${_passwordController.text}");

      // Validate email and password fields
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        // Show error message if email or password is empty
        MotionToast.error(
          height: 50.h,
          animationDuration: const Duration(milliseconds: 300),
          description: const Text("Please provide both email and password."),
        ).show(context);
        return; // Exit the function if validation fails
      }

      // Attempt to log in using provided credentials
      // Attempt to log in using provided credentials
      LoginRepository loginRepository = LoginRepository();
      Map<String, dynamic> loginResult = await loginRepository.login(LoginModel(
        email: _emailController.text,
        password: _passwordController.text,
        // token: token!,
      ));
      print("Login Result: $loginResult");

      // Extract login result
      bool isLogin = loginResult['success'] == true;
      bool isStaff = loginResult['is_Staff'] == true;
      bool isAdmin = loginResult['is_Admin'] == true;
      

      String? responseRole = loginResult['role'];
      print("signin responseRole is $responseRole");
              SharedPreferences prefs = await SharedPreferences.getInstance();

int? wardno = prefs.getInt('wardno');
      print("Signin ward no is $wardno");

      if (isLogin) {
        if (isStaff || responseRole == "staff") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>

                    //  const AdminHomePage()),
                    StaffHomePage(
                      wardno: wardno,
                    )),
          );
        } else if (isAdmin || responseRole == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserHomePage()),
            // const AdminHomePage()),
          );
        }
      } else {
        // If login fails, display an appropriate error message
        MotionToast.error(
          height: 50.h,
          animationDuration: const Duration(milliseconds: 300),
          description: const Text("Invalid email or password."),
        ).show(context);
      }
    } catch (e) {
      // Handle any unexpected errors that occur during the login process
      print("Error during login: $e");
      MotionToast.error(
        height: 50.h,
        animationDuration: const Duration(milliseconds: 300),
        description:
            const Text("An unexpected error occurred. Please try again later."),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // const SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Image(
                          image: const AssetImage(
                            'assets/images/Eco.png',
                          ),
                          height: 100.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 80.h),
                        child: Text('SAFA SAHAR', style: kHeadline),
                      ),

                      MyTextField(
                        hintText: 'Enter Email',
                        inputType: TextInputType.text,
                        controller: _emailController,
                        formKey: _formKey,
                        isEditable: true,
                        onChanged: (value) {}, // Fixed typo here
                      ),
                      // const SizedBox(height: 20),
                      MyPasswordField(
                        formKey: _formKey,
                        controller: _passwordController,
                        isPasswordVisible: isPasswordVisible,
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 25.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: kBodyText.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      MyTextButton(
                        buttonName: 'Sign In',
                        bgColor: Colors.green,
                        textColor: Colors.black87,
                        // onTap: () async {
                        //   // Validate if email is not empty
                        //   if (_emailController.text.isEmpty) {
                        //     // Show an error message or handle empty email
                        //     return;
                        //   }

                        //   // Now, you can check if the user is registered and navigate accordingly
                        //   bool isUserRegistered =
                        //       await AuthService.isUserRegistered(
                        //           _emailController.text);

                        //   if (isUserRegistered) {
                        //     // Navigate to HomePage
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const HomePage()),
                        //     );
                        //   } else {
                        //     // Show a message indicating that the user is not registered
                        //     showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //           title: const Text('User Not Registered'),
                        //           content: const Text('Please register first.'),
                        //           actions: [
                        //             TextButton(
                        //               onPressed: () {
                        //                 Navigator.pop(context);
                        //               },
                        //               child: const Text('OK'),
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     );
                        //   }
                        // },
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   // Validation succeeded, proceed with registration
                          //   _loginUser();
                          // } else {
                          //   print("Validation error");
                          //   // Validation failed, do not proceed
                          //   // You can optionally display an error message to the user
                          // }
                          FocusScope.of(context).unfocus();

                          _loginUser();
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New here? ", style: kBodyText),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const SignUp(),
                                  ),
                                );
                              },
                              child: Text(
                                'Register',
                                style: kBodyText.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

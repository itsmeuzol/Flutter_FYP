import 'package:finalyear/domain/signup/signUp_repository.dart/signUP_repository.dart';
import 'package:finalyear/domain/signup/signupModel/signUpModel.dart';
import 'package:finalyear/presentation/screens/login/signin_page.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/verifyMail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/widget.dart';
import '../../../components/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool passwordVisibility = true;

  // Define controllers for your text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _housenoController = TextEditingController();
  final TextEditingController _wardnoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _locationController.dispose();
    _housenoController.dispose();
    _wardnoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _clearSharedPreferences();
    // verifyEmail("token");
  }

  Future<void> _clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_token');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('user');
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('location');
    await prefs.remove('phone');
    await prefs.remove('wardno');
  }

  _registerUser() async {
    try {
      // _formKey.currentState!.validate();

      if (_fullNameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _phoneController.text.isEmpty ||
          _locationController.text.isEmpty ||
          _housenoController.text.isEmpty ||
          _wardnoController.text.isEmpty) {
        // Show error message if email or password is empty
        MotionToast.error(
          height: 50.h,
          animationDuration: const Duration(milliseconds: 300),
          description: const Text("All the fields are mandatory"),
        ).show(context);
        return; // Exit the function if validation fails
      }

      if (_formKey.currentState!.validate()) {
        UserRepository userRepository = UserRepository();
        bool isRegister = await userRepository.register(SignUpModel(
          name: _fullNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
          location: _locationController.text,
          houseno: int.parse(_housenoController.text),
          wardno: int.parse(_wardnoController.text),
          role: "user",
        ));

        if (isRegister) {
          // Store the token locally
          // Retrieve the token from shared_preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString('token');
          Navigator.push(
            context,
            // MaterialPageRoute(builder: (context) => const SignInPage()));
            MaterialPageRoute(
                builder: (context) =>
                    VerifyMail(registeredVerifyToken: token!)),
          );

          // AuthController.login();
        } else {
          MotionToast.error(
                  height: 50.h,
                  animationDuration: const Duration(milliseconds: 200),
                  description: const Text("User already exists"))
              .show(context);
        }
      }
    } catch (e) {
      MotionToast.error(
        height: 50.h,
        animationDuration: const Duration(milliseconds: 300),
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Image(
                              image: const AssetImage(
                                'assets/images/Eco.png',
                              ),
                              height: 100.h,
                            ),
                          ),
                          Text(
                            'SAFA SAHAR',
                            style: kHeadline,
                          ),
                          // const Text(
                          //   "Register",
                          //   style: kHeadline,
                          // ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                MyTextField(
                                  // formKey: _formKey,
                                  hintText: 'Full Name',
                                  controller: _fullNameController,
                                  inputType: TextInputType.name,
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your full name'
                                      : null,
                                  isEditable: true,
                                  onChanged: (value) {},
                                ),
                                MyTextField(
                                  hintText: 'Location',
                                  controller: _locationController,
                                  inputType: TextInputType.text,
                                  onDropdownPressed: () {
                                    location(context,
                                        _locationController); // Call the _wardno method
                                  },
                                  // formKey: _formKey,
                                  showDropdownIcon: true,
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your location'
                                      : null,
                                  isEditable: false,
                                  onChanged: (value) {},
                                ),
                                MyTextField(
                                  hintText: 'House No',
                                  showDropdownIcon: true,
                                  onDropdownPressed: () {
                                    houseno(context, _housenoController);
                                  },
                                  controller: _housenoController,
                                  inputType: TextInputType.text,
                                  // formKey: _formKey,
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your house no'
                                      : null,
                                  isEditable: false,
                                  onChanged: (value) {},
                                ),
                                MyTextField(
                                  hintText: 'Ward No',
                                  showDropdownIcon: true,
                                  onDropdownPressed: () {
                                    wardno(context,
                                        _wardnoController); // Call the _wardno method
                                  },
                                  controller: _wardnoController,
                                  inputType: TextInputType.text,
                                  // formKey: _formKey,
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your ward no'
                                      : null,
                                  isEditable: false,
                                  onChanged: (value) {},
                                ),
                                MyTextField(
                                  hintText: 'Email',
                                  controller: _emailController,
                                  inputType: TextInputType.emailAddress,
                                  validator: _validateEmail,
                                  // formKey: _formKey,
                                  isEditable: true,
                                  onChanged: (value) {},
                                ),

                                MyTextField(
                                  hintText: 'Phone',
                                  controller: _phoneController,
                                  inputType: TextInputType.phone,
                                  validator: _validatePhoneNumber,
                                  // formKey: _formKey,
                                  isEditable: true,
                                  onChanged: (value) {},
                                ),
                                // MyPasswordField(
                                //   formKey: _formKey,
                                //   validator: (name) => name!.isEmpty
                                //       ? 'Please enter your password'
                                //       : null,
                                //   controller: _passwordController,
                                //   isPasswordVisible: passwordVisibility,
                                //   onTap: () {
                                //     setState(() {
                                //       passwordVisibility = !passwordVisibility;
                                //     });
                                //   },
                                // )

                                MyPasswordField(
                                  // formKey: _formKey,
                                  validator: _validatePassword,
                                  controller: _passwordController,
                                  isPasswordVisible: passwordVisibility,
                                  onTap: () {
                                    setState(() {
                                      passwordVisibility = !passwordVisibility;
                                    });
                                  },
                                ),

                                SizedBox(
                                  height: 10.h,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          child: Text.rich(
                            TextSpan(
                              text: "Sign In",
                              style: kBodyText.copyWith(
                                color: Colors.red,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to RegisterPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInPage()),
                                  );
                                },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
                      child: MyTextButton(
                        buttonName: 'Register',
                        bgColor: Colors.green,
                        textColor: Colors.black87,
                        onPressed: () {
                          _registerUser();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? email) {
    RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Please enter a phone number';
    }

    // String sanitizedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (phoneNumber.length != 10) {
      return 'Phone number must be 10 digits long';
    }

    return null;
  }

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}

// import 'package:finalyear/presentation/screens/admin_main/adminHomepage/adminHomepage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:finalyear/presentation/screens/screen.dart';

// class Splash extends StatelessWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     _navigateToHome(
//         context); // Call the navigation method when building the widget
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildSplashImage(),
//             _buildCopyrightText(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSplashImage() {
//     return SizedBox(
//       height: 300.h,
//       width: 300.w,
//       child: Image.asset("assets/images/splash.png"),
//     );
//   }

//   Widget _buildCopyrightText() {
//     return Column(
//       children: [
//         Text(
//           '© Copyright Safa Sahar 2023',
//           style: TextStyle(
//             fontSize: ScreenUtil().setSp(13),
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   void _navigateToHome(BuildContext context) async {
//     await Future.delayed(const Duration(seconds: 5));
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const SignUp()),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:finalyear/presentation/screens/screen.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _navigateToHome(
        context); // Call the navigation method when building the widget
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSplashImage(),
            _buildCopyrightText(),
          ],
        ),
      ),
    );
  }

  Widget _buildSplashImage() {
    return SizedBox(
      height: 300.h,
      width: 300.w,
      child: Image.asset("assets/images/splash.png"),
    );
  }

  Widget _buildCopyrightText() {
    return Column(
      children: [
        Text(
          '© Copyright Safa Sahar 2023',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(13),
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    // Check if the context's navigator can still pop
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }
}

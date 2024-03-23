import 'package:finalyear/presentation/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:finalyear/presentation/screens/admin_main/adminHomepage/adminHomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('token');
  runApp(MyApp(authToken: authToken)); // Pass authToken to MyApp
}

class MyApp extends StatelessWidget {
  final String? authToken; // Declare authToken as a field

  const MyApp({Key? key, this.authToken})
      : super(key: key); // Update constructor
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Sign In Sign Up ',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(216, 243, 220, 2),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: const HomePage(),
        // home: const Splash(),
        home: authToken != null
            ? const AdminHomePage() // change garna parxa
            : const Splash(),
      ),
    );
  }
}

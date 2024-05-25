import 'package:finalyear/presentation/screens/login/signin_page.dart';
import 'package:finalyear/presentation/screens/profile/my_profile.dart';
import 'package:finalyear/presentation/screens/user_main/payment/payment_screen.dart';
import 'package:finalyear/presentation/screens/users/userReport.dart';
import 'package:finalyear/presentation/screens/users/user_aboutuspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAppBarWithDrawer extends StatefulWidget {
  final String title;
  final Widget body;
  const UserAppBarWithDrawer({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<UserAppBarWithDrawer> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UserAppBarWithDrawer> {
  final listTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(138, 201, 38, 1),
          ),
          backgroundColor: const Color.fromRGBO(0, 62, 31, 0.9),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: const Color.fromRGBO(138, 201, 38, 1),
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        height: 0.04.h,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfile()),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15.r,
                      backgroundImage:
                          const AssetImage('assets/images/user.jpg'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width *
              0.8, // Adjust the width as needed

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 70.h),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/Eco.png'), // Replace with your actual photo path
                    // Adjust the radius as needed
                  ),
                  title: Text(
                    'SAFA SAHAR',
                    style: TextStyle(
                        color: const Color.fromRGBO(0, 62, 31, 2),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        scaffoldKey.currentState?.closeDrawer();
                      }),
                ),
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.payment),
                title: Text(
                  'Payment',
                  style: listTextStyle,
                ),
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentScreen()),
                  );
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.file_copy_rounded),
                title: Text(
                  'Report',
                  style: listTextStyle,
                ),
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserReportPage()),
                  );
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.info),
                title: Text(
                  'About Us',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AboutUs())));
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.logout),
                title: Text(
                  'Log out',
                  style: listTextStyle,
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  // token removed
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

                  print("token removed");

                  // Navigate to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
              ),
              const Divider(
                color: Colors.green,
              ),
            ],
          ),
        ),
        body: widget.body);
  }
}

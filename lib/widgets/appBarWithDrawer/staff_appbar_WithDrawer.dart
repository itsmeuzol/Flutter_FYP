import 'package:finalyear/presentation/screens/admin_main/adminside/adminProfile.dart';
import 'package:finalyear/presentation/screens/login/signin_page.dart';
import 'package:finalyear/presentation/screens/staff_main/get_users_acc_ward.dart';
import 'package:finalyear/presentation/screens/staff_main/staff_get_user_report.dart/staff_get_user_report.dart';
import 'package:finalyear/presentation/screens/staff_main/staff_profile/staff_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffAppBarWithDrawer extends StatefulWidget {
  final String title;
  final Widget body;
  const StaffAppBarWithDrawer({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<StaffAppBarWithDrawer> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StaffAppBarWithDrawer> {
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
                          builder: (context) => const StaffProfile()),
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
                leading: const Icon(Icons.people),
                title: Text(
                  'Registered Users',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StaffGetUsers()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.report),
                title: Text(
                  "User's Report",
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StaffGetUserReport()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StaffProfile()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: listTextStyle,
                ),
                onTap: () async {
                  // Clear user session (remove token from shared_preferences)
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('token');
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

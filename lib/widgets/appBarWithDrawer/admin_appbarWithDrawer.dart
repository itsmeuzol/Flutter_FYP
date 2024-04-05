import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbin.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/adminNotification/adminNotification.dart';
import 'package:finalyear/presentation/screens/hamdrawerpages/mapview/mapviewpage.dart';
import 'package:finalyear/presentation/screens/login/signin_page.dart';
import 'package:finalyear/presentation/screens/profile/my_profile.dart';
import 'package:finalyear/presentation/screens/users/getAllUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAppBarWithDrawer extends StatefulWidget {
  final String title;
  final Widget body;
  const AdminAppBarWithDrawer({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<AdminAppBarWithDrawer> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AdminAppBarWithDrawer> {
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
            color: const Color.fromRGBO(138, 201, 38, 1),
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
                          const AssetImage('assets/images/google_logo.png'),
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
                        color: Color.fromRGBO(0, 62, 31, 2),
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
                  'Users',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetAllUsers()),
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
                        builder: (context) => const UserProfile()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.location_on),
                title: Text(
                  'Map View',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapViewPage()),
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
                  print("token removed");

                  // Navigate to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
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

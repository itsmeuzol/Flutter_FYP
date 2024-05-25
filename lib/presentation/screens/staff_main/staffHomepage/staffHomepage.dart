import 'package:finalyear/presentation/screens/staff_main/get_users_acc_ward.dart';
import 'package:finalyear/presentation/screens/staff_main/staffHomepage/staff_dashboard.dart';
import 'package:finalyear/presentation/screens/staff_main/staff_bulk_req/staff_bulk_req.dart';
import 'package:finalyear/presentation/screens/staff_main/staff_profile/staff_profile.dart';
import 'package:flutter/material.dart';

class StaffHomePage extends StatefulWidget {
  final int? wardno;
  const StaffHomePage({super.key, this.wardno});

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  int _selectedIndex = 0;
  void _navigatorBottomNavBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  List<Widget> _children(BuildContext context) {
    return [
      const StaffDashboard(),
      const StaffBulkRequest(),
      const StaffGetUsers(),
      const StaffProfile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _children(context)[_selectedIndex],
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }

  BottomNavigationBar CustomBottomNavBar() {
    return BottomNavigationBar(
        backgroundColor: const Color(0xFF52B788),
        fixedColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _navigatorBottomNavBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.send,
              size: 30,
            ),
            label: "Bulk Request",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              size: 30,
            ),
            label: "Registered Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: "Profile",
          ),
        ]);
  }
}

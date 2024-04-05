import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbin.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/addstaff.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/adminNotification/adminNotification.dart';
import 'package:finalyear/presentation/screens/staff_main/staffHomepage/staff_dashboard.dart';
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
      StaffDashboard(wardno: widget.wardno),
      const AdminAddDustbin(),
      const AdminAddStaff(),
      const AdminNotificationPage(),
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
              Icons.delete_outline,
              size: 30,
            ),
            label: "Dustbin",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              size: 30,
            ),
            label: "People",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 30,
            ),
            label: "Notifications",
          ),
        ]);
  }
}

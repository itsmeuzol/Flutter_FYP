import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbin.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/addstaff.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/pickup/adminAddPikupTime.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/ui/admindashboard.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;
  void _navigatorBottomNavBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  //different pages to navigate
  final List<Widget> _children = [
    const AdminDashboard(),
    const AdminAddDustbin(),
    const AdminAddStaff(),
    const AdminAddPIckUpTime(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _children[_selectedIndex],
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
            label: "Add Pickup time",
          ),
        ]);
  }
}

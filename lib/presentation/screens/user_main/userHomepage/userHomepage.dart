import 'package:finalyear/presentation/screens/user_main/payment/payment_screen.dart';
import 'package:finalyear/presentation/screens/user_main/user_awarness/user_awareness.dart';
import 'package:finalyear/presentation/screens/users/wastePickup.dart';
import 'package:finalyear/presentation/screens/users/userReport.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0;
  void _navigatorBottomNavBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  //different pages to navigate
  final List<Widget> _children = [
     UserAwareness(),
    const UserReportPage(),
    const PaymentScreen(),
    // const UserProfile(),
    const UserWastePickup(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: CustomBottomNavBarUser(),
      ),
    );
  }

  BottomNavigationBar CustomBottomNavBarUser() {
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
              Icons.camera_alt,
              size: 30,
            ),
            label: "Report",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.payment,
              size: 30,
            ),
            label: "Payment",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.schedule,
              size: 30,
            ),
            label: "Schedule",
          ),
        ]);
  }
}

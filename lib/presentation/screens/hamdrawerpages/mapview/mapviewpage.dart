import 'package:finalyear/components/constants.dart';
import 'package:finalyear/googlemapapi/googlemap.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbin.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/addstaff.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/adminNotification/adminNotification.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/ui/admindashboard.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/widgets/dustbinnumber.dart';
//import 'package:finalyear/googlemapapi/googlemap.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


// class MapViewPage extends StatefulWidget {
//   const MapViewPage({super.key});

//   @override
//   State<MapViewPage> createState() => _MapViewPageState();
// }

// class _MapViewPageState extends State<MapViewPage> {
//   @override
//   Widget build(BuildContext context) {
//     return AdminAppBarWithDrawer(
//       title: 'ADMIN',
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "MAP VIEW",
//                 style: subhead.copyWith(color: const Color(0xFF365307)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.h),
//               child: Container(
//                   height: 400,
//                   width: double.infinity,
//                   color: Colors.red,
//                   child: const MapPage()),
//             ),
//             // const SizedBox(
//             //   height: 100,
//             // ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//               child: SizedBox(
//                 height: 165.h,
//                 width: double.infinity,
//                 child: ResponsiveGridList(
//                     horizontalGridSpacing: 10,
//                     verticalGridSpacing: 15,
//                     verticalGridMargin: 10,
//                     minItemWidth: 10,
//                     minItemsPerRow: 2,
//                     maxItemsPerRow: 2,
//                     listViewBuilderOptions: ListViewBuilderOptions(),
//                     children: [
//                       builddustbinbox(title: 'Full Dustbin', onPressed: () {}),
//                       builddustbinbox(title: 'Half Dustbin', onPressed: () {}),
//                       builddustbinbox(title: 'Empty Dustbin', onPressed: () {}),
//                       builddustbinbox(title: 'Damage Dustbin', onPressed: () {})
//                     ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class MapViewPage extends StatefulWidget {
  const MapViewPage({Key? key}) : super(key: key);

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminAppBarWithDrawer(
        title: 'ADMIN',
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "MAP VIEW",
                  style: subhead.copyWith(color: const Color(0xFF365307)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  color: Colors.red,
                  child: const MapPage(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: SizedBox(
                  height: 165.h,
                  width: double.infinity,
                  child: ResponsiveGridList(
                    horizontalGridSpacing: 10,
                    verticalGridSpacing: 15,
                    verticalGridMargin: 10,
                    minItemWidth: 10,
                    minItemsPerRow: 2,
                    maxItemsPerRow: 2,
                    listViewBuilderOptions: ListViewBuilderOptions(),
                    children: [
                      builddustbinbox(title: 'Full Dustbin', onPressed: () {}),
                      builddustbinbox(title: 'Half Dustbin', onPressed: () {}),
                      builddustbinbox(title: 'Empty Dustbin', onPressed: () {}),
                      builddustbinbox(
                          title: 'Damage Dustbin', onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: DefaultCustomBottomNavBar(
      //   selectedIndex: _selectedIndex,
      //   onItemTapped: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // )
    );
  }
}

class DefaultCustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  DefaultCustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  State<DefaultCustomBottomNavBar> createState() =>
      _DefaultCustomBottomNavBarState();
}

class _DefaultCustomBottomNavBarState extends State<DefaultCustomBottomNavBar> {
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
    const AdminNotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF52B788),
        fixedColor: Colors.black,
        currentIndex: widget.selectedIndex,
        onTap: widget.onItemTapped,
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
        ],
      ),
    );
  }
}

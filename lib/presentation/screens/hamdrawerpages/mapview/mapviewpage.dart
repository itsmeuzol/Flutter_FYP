import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/googlemapapi/googlemap.dart';
import 'package:finalyear/presentation/screens/admin_main/adminHomepage/adminHomepage.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbin.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/addstaff.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/pickup/adminAddPikupTime.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/ui/admindashboard.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/widgets/dustbinnumber.dart';
import 'package:finalyear/utils/urls.dart';
//import 'package:finalyear/googlemapapi/googlemap.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:http/http.dart' as http;

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
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

int fullDustbin = 0;
int halfDustbin = 0;
int emptyDustbin = 0;
int damagedDustbin = 0;

class _MapViewPageState extends State<MapViewPage> {
  @override
  void initState() {
    super.initState();
    fetchDustbinStats();
  }

  Future<void> fetchDustbinStats() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + getDustbinStats));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          fullDustbin = data['data']['Full Dustbin'];
          halfDustbin = data['data']['Half Dustbin'];
          emptyDustbin = data['data']['Empty Dustbin'];
          damagedDustbin = data['data']['Damaged Dustbin'];

          print(
              "Full Dustbin: $fullDustbin, Half Dustbin: $halfDustbin, Empty Dustbin: $emptyDustbin, Damaged Dustbin: $damagedDustbin");
        });
      } else {
        print('Failed to fetch dustbin stats: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching dustbin stats: $error');
    }
  }

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminAppBarWithDrawer(
        title: 'ADMIN',
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomBackIcon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AdminHomePage();
                      }));
                    },
                  )
                ],
              ),
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
                      builddustbinbox(
                          title: 'Full Dustbin',
                          onPressed: () {},
                          count: fullDustbin.toString()),
                      builddustbinbox(
                          title: 'Half Dustbin',
                          onPressed: () {},
                          count: halfDustbin.toString()),
                      builddustbinbox(
                          title: 'Empty Dustbin',
                          onPressed: () {},
                          count: emptyDustbin.toString()),
                      builddustbinbox(
                          title: 'Damage Dustbin',
                          onPressed: () {},
                          count: damagedDustbin.toString()),
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
  const DefaultCustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

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
    const AdminAddPIckUpTime(),
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

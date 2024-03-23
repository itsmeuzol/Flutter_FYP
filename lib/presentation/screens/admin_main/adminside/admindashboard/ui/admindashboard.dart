import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/widgets/activeuser_widget.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/widgets/buildchart.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/widgets/dustbinnumber.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'package:http/http.dart' as http;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<dynamic> staffList = []; // List to store staff data
  List<dynamic> dustbinList = []; // List to store staff data

  int totalStaff = 0; // Declare totalStaff as a class member
  int totalDustbin = 0;

  @override
  void initState() {
    super.initState();
    fetchStaffData(); // Call the function to fetch staff data when the widget initializes
    fetchDustbinData();
  }

  // Function to fetch staff data from API
  Future<void> fetchStaffData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + getStaff));
      if (response.statusCode == 200) {
        setState(() {
          staffList = jsonDecode(response.body)['staffMembers'];
          totalStaff = staffList.length; // Update totalStaff here
        });
      } else {
        print('Failed to fetch staff data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching staff data: $error');
    }
  }

// dustbin
  Future<void> fetchDustbinData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + getDustbinUrl));
      if (response.statusCode == 200) {
        setState(() {
          // Parse the response correctly
          var responseData = jsonDecode(response.body);
          if (responseData['success'] == true) {
            dustbinList = responseData['data'];
            totalDustbin = dustbinList.length; // Update totalDustbin here
            print("Total dustin is $totalDustbin");
          } else {
            print('Failed to fetch dustbin data: ${response.statusCode}');
          }
        });
      } else {
        print('Failed to fetch dustbin data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching dustbin data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return AdminAppBarWithDrawer(
    return WillPopScope(
      onWillPop: () async => false,
      child: AdminAppBarWithDrawer(
        title: 'ADMIN',
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "DASHBOARD",
                    style: kBodyText2.copyWith(
                        color: const Color(0xFF365307), letterSpacing: 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: SizedBox(height: 180.h, child: buildChart()),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: SizedBox(
                  height: 165.h,
                  width: double.infinity,
                  child: ResponsiveGridList(
                      horizontalGridSpacing: 10.w,
                      verticalGridSpacing: 10.h,
                      verticalGridMargin: 10.w,
                      minItemWidth: 10.w,
                      minItemsPerRow: 2,
                      maxItemsPerRow: 2,
                      listViewBuilderOptions: ListViewBuilderOptions(),
                      children: [
                        builddustbinbox(
                            title: 'Full Dustbin', onPressed: () {}),
                        builddustbinbox(
                            title: 'Half Dustbin', onPressed: () {}),
                        builddustbinbox(
                            title: 'Empty Dustbin', onPressed: () {}),
                        builddustbinbox(
                            title: 'Damage Dustbin', onPressed: () {})
                      ]),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 5.h),
                child: Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        20.r), // Adjust the value as needed
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Text("STAFFS", style: kBodyText),
                          ),
                        ],
                      ),
                      buildActiveUsersWidget("ACTIVE USERS", totalStaff),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      buildActiveUsersWidget("TOTAL DUSTBINS", totalDustbin),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      // buildActiveUsersWidget("TOTAL DUSTBINS", 10),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DustbinData {
  String year;
  int y;
  int y1;
  int y2;

  DustbinData(
    this.year,
    this.y,
    this.y1,
    this.y2,
  );
}

dynamic getColumnData() {
  List<DustbinData> columnData = <DustbinData>[
    DustbinData(
      '2023-12-14',
      20,
      50,
      100,
    ),
    DustbinData(
      "2023-12-15",
      30,
      20,
      80,
    ),
    DustbinData(
      "2023-12-16",
      40,
      10,
      30,
    ),
    DustbinData(
      "2023-12-20",
      50,
      20,
      30,
    )
  ];
  return columnData;
}

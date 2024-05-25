import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/admindashboard/widgets/dustbinnumber.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/staff_appbar_WithDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StaffDashboard extends StatefulWidget {
  // final int? wardno;
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  List<dynamic> staffList = []; // List to store staff data
  List<dynamic> dustbinList = [];
  List<dynamic> userList = [];

  int? totalStaff = 0;
  int? totalDustbin = 0;

  int? fullDustbin = 0;
  int? halfDustbin = 0;
  int? emptyDustbin = 0;
  int? damageDustbin = 0;

  int wardno = 0;

  Future<void> getStaffData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      wardno = prefs.getInt('wardno') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDustbinData();
    fetchDustbinStats();
    // fetchUserByWard(widget.wardno!);
    getStaffData().then((_) {
      fetchUserByWard(wardno); // Corrected: parse wardno to int
    });
  }

  Future<void> fetchDustbinStats() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + getDustbinStats));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          // Update variables with data from the response
          fullDustbin = data['data']['Full Dustbin'];
          halfDustbin = data['data']['Half Dustbin'];
          emptyDustbin = data['data']['Empty Dustbin'];
          damageDustbin = data['data']['Damaged Dustbin'];

          print(
              "Full Dustbin staff: $fullDustbin, Half Dustbin staf: $halfDustbin, Empty Dustbin: $emptyDustbin, Damaged Dustbin: $damageDustbin");
        });
      } else {
        print('Failed to fetch dustbin stats: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching dustbin stats: $error');
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

  Future<void> fetchUserByWard(int wardno) async {
    try {
      userList.clear();

      final response = await http
          .get(Uri.parse('$baseUrl$getUserByWard?wardno=$wardno'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Extract staff members' names, locations, and emails
        final List<dynamic> userMembers = data['users'];

        for (var users in userMembers) {
          final int id = users['id'];
          final String name = users['name'];
          final String? location = users['location'];
          final int? houseno = users['houseno'];
          final String? email = users['email'];
          final int? wardno = users['wardno'];
          final String? phone = users['phone'];
          print(
              'ID r: $id, Name: $name, Location: $location, Houseno: $houseno Email: $email, Ward: $wardno, Phone:$phone,');
          // Add staff details to the staff list
          userList.add({
            'id': id.toString(),
            'name': name,
            'location': location!,
            'houseno': houseno.toString(),
            'email': email!,
            'wardno': wardno.toString(),
            'phone': phone.toString(),
          });
        }
        setState(() {});
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please try again")),
        );
        print('Failed to fetch users: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching users: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // return AdminAppBarWithDrawer(
    return WillPopScope(
      onWillPop: () async => false,
      child: StaffAppBarWithDrawer(
        title: 'STAFF',
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
                  child: SizedBox(
                      height: 180.h,
                      child: buildChart(
                          fullDustbin!, emptyDustbin!, damageDustbin!)),
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
                            count: damageDustbin.toString()),
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
                            child: Text("Users in my ward", style: kBodyText),
                          ),
                        ],
                      ),
                      buildActiveUsersWidgetStaffScreen(
                          "ACTIVE USERS", userList.length),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      buildActiveUsersWidgetStaffScreen(
                          "TOTAL DUSTBINS", totalDustbin!),
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

Widget buildChart(int fullDustbin, int emptyDustbin, int damageDustbin) {
  return SizedBox(
    child: SfCartesianChart(
      title: const ChartTitle(
          text: 'Dustbin Overview',
          textStyle:
              TextStyle(color: Color(0xFF365307), fontWeight: FontWeight.bold)),
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(minimum: 0, maximum: 100, interval: 5),
      series: <CartesianSeries>[
        // Full Dustbin Series
        ColumnSeries<DustbinData, String>(
          dataSource: [
            DustbinData('Full Dustbin', fullDustbin, 0, 0),
          ],
          xValueMapper: (DustbinData dustbin, _) => dustbin.year,
          yValueMapper: (DustbinData dustbin, _) => dustbin.y,
          color: Colors.green,
        ),
        // Empty Dustbin Series
        ColumnSeries<DustbinData, String>(
          dataSource: [
            DustbinData('Empty Dustbin', emptyDustbin, 0, 0),
          ],
          xValueMapper: (DustbinData dustbin, _) => dustbin.year,
          yValueMapper: (DustbinData dustbin, _) => dustbin.y,
          color: Colors.yellow,
        ),
        // Damaged Dustbin Series
        ColumnSeries<DustbinData, String>(
          dataSource: [
            DustbinData('Damaged Dustbin', damageDustbin, 0, 0),
          ],
          xValueMapper: (DustbinData dustbin, _) => dustbin.year,
          yValueMapper: (DustbinData dustbin, _) => dustbin.y,
          color: Colors.red,
        ),
      ],
    ),
  );
}

Widget buildActiveUsersWidgetStaffScreen(
    String activeUsersText, int totalUsers) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
    child: Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(45.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(activeUsersText,
                style: kBodyText.copyWith(
                  color: const Color(0xFF003E1F),
                  fontWeight: FontWeight.w500,
                )),
            Text("TOTAL: $totalUsers",
                style: kBodyText.copyWith(
                  color: const Color(0xFF003E1F),
                  fontWeight: FontWeight.w500,
                ))
          ],
        ),
      ),
    ),
  );
}

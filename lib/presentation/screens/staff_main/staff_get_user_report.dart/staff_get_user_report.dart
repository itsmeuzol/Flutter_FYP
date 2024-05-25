import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/staff_main/staffHomepage/staffHomepage.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/staff_appbar_WithDrawer.dart';
import 'package:finalyear/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffGetUserReport extends StatefulWidget {
  // final int? wardno;

  const StaffGetUserReport({super.key});

  @override
  State<StaffGetUserReport> createState() => _StaffGetUserReportState();
}

class _StaffGetUserReportState extends State<StaffGetUserReport> {
  List<Map<String, String>> userReportslist = [];

  int wardno = 0;

  Future<void> getStaffData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      wardno = prefs.getInt('wardno') ?? 0;
      print("staff ward no is $wardno");
    });
  }

  @override
  void initState() {
    super.initState();
    // Call getStaffData and wait for it to complete before calling fetchUserReportbyWard
    getStaffData().then((_) {
      fetchUserReportbyWard(wardno); // Corrected: parse wardno to int
    });
  }

  Future<void> fetchUserReportbyWard(int wardno) async {
    try {
      userReportslist.clear(); //yo herna parchha

      final response =
          await http.get(Uri.parse('$baseUrl$getReportAccWard?wardno=$wardno'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Extract staff members' names, locations, and emails
        final List<dynamic> userDatas = data['data'];

        for (var users in userDatas) {
          // final int id = users['id'];
          final int? wardno = users['wardno'];
          final String? location = users['location'];
          final String? name = users['name'];
          final String? email = users['email'];

          final String? details = users['details'];

          print(
              "wardno $wardno, location $location, name $name, email $email, details $details");
          userReportslist.add({
            // 'id': id.toString(),
            'wardno': wardno.toString(),
            'location': location ?? '',
            'name': name ?? '',
            'email': email ?? '',
            'details': details ?? '',
          });
        }

        setState(() {}); // Notify that the state has changed
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please try again")),
        );
        print('Failed to fetch : ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching users report: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StaffAppBarWithDrawer(
      title: 'STAFF',
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomBackIcon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const StaffHomePage();
                      }));
                    },
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "User's report of ward: $wardno",
                    style: kBodyText2.copyWith(
                        color: const Color(0xFF365307), letterSpacing: 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // FutureBuilder<List<dynamic>>(
              //   future: _futurePaymentDetails,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return CircularProgressIndicator();
              //     } else if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     } else {
              //       return _buildDetailsBox(snapshot.data);
              //     }
              //   },
              // ),
              _buildDetailsBox(userReportslist),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailsBox(List<dynamic>? userDetailsOK) {
  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  return Container(
    // padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(82, 183, 136, 0.5)),

      // color: const Color.fromRGBO(82, 183, 136, 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.green[200]!),
        columnSpacing: 16,
        dataRowColor:
            MaterialStateColor.resolveWith((states) => Colors.green[100]!),
        columns: const [
          DataColumn(
            label: Text(
              'Name',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Email',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Ward no',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Details',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
        rows: userDetailsOK?.map((usersOk) {
              return DataRow(cells: [
                DataCell(Text(usersOk['name'] ?? '',
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(usersOk['email'] ?? '',
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(usersOk['wardno'].toString(),
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(usersOk['details'],
                    style: const TextStyle(color: Colors.black))),
              ]);
            }).toList() ??
            [],
      ),
    ),
  );
}

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

class AdminGetStaffBulkReport extends StatefulWidget {
  // final int? wardno;

  const AdminGetStaffBulkReport({super.key});

  @override
  State<AdminGetStaffBulkReport> createState() =>
      _AdminGetStaffBulkReportState();
}

class _AdminGetStaffBulkReportState extends State<AdminGetStaffBulkReport> {
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
      fetchBulkReport(); // Corrected: parse wardno to int
    });
  }

  Future<void> fetchBulkReport() async {
    try {
      userReportslist.clear(); //yo herna parchha

      final response = await http.get(Uri.parse('$baseUrl$getBulkRequest'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Extract staff members' names, locations, and emails
        final List<dynamic> userDatas = data['data'];

        for (var users in userDatas) {
          final int id = users['id'];
          final int? wardno = users['wardno'];
          final String? location = users['location'];
          // final String? name = users['name'];
          // final String? email = users['email'];

          final String? message = users['message'];

          print("wardno $wardno, location $location,   ");
          userReportslist.add({
            'id': id.toString(),
            'wardno': wardno.toString(),
            'location': location ?? '',
            'message': message ?? '',
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
      print('Error fetching bulk report: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  }

  Future<void> _refreshBulkReportok() async {
    try {
      await fetchBulkReport();
    } catch (error) {
      print('Error refreshing bulk report: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to refresh user report")),
      );
    }
  }

  void deleteBulkReport(String id) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl$deleteBulkReportById?id=$id'));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Report deleted successfully')),
        );
        _refreshBulkReportok();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete user report')),
        );
      }
    } catch (error) {
      // Handle errors
      print('Error deleting dustbin: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          // padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(82, 183, 136, 0.5)),

            // color: const Color.fromRGBO(82, 183, 136, 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.green[200]!),
              columnSpacing: 28,
              dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.green[100]!),
              columns: const [
                DataColumn(
                  label: Text(
                    'Ward no',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Location',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Message',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: userReportslist?.map((usersOk) {
                    return DataRow(cells: [
                      DataCell(Text(usersOk['wardno'] ?? '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(usersOk['location'] ?? '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(usersOk['message'].toString(),
                          style: const TextStyle(color: Colors.black))),
                      DataCell(
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[600],
                          ),
                          onPressed: () {
                            deleteBulkReport(usersOk['id']!);
                          },
                        ),
                      ),
                    ]);
                  }).toList() ??
                  [],
            ),
          ),
        ),
      ),
    );
  }
}

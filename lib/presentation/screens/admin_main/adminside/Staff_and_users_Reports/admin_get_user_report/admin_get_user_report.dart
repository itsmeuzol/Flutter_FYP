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

class AdminGetUserReport extends StatefulWidget {
  // final int? wardno;

  const AdminGetUserReport({super.key});

  @override
  State<AdminGetUserReport> createState() => _AdminGetUserReportState();
}

class _AdminGetUserReportState extends State<AdminGetUserReport> {
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
      fetchUserReport(); // Corrected: parse wardno to int
    });
  }

  Future<void> fetchUserReport() async {
    try {
      userReportslist.clear();

      final response = await http.get(Uri.parse('$baseUrl$getReport'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> userDatas = data['data'];

        for (var userData in userDatas) {
          final int? id = userData['id']; // Extract id from userData
          final int? wardno = userData['wardno'];
          final String? location = userData['location'];
          final String? name = userData['name'];
          final String? email = userData['email'];
          final String? details = userData['details'];

          userReportslist.add({
            'id': id.toString(), // Add the id to the list
            'wardno': wardno.toString(),
            'location': location ?? '',
            'name': name ?? '',
            'email': email ?? '',
            'details': details ?? '',
          });
        }

        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to fetch user reports")),
        );
        print('Failed to fetch : ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching users report: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch user reports")),
      );
    }
  }

  Future<void> _refreshUserReportok() async {
    try {
      await fetchUserReport();
    } catch (error) {
      print('Error refreshing user report: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to refresh user report")),
      );
    }
  }

  void deleteUserReports(String id) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl$deleteUserReport?id=$id'));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Report deleted successfully')),
        );
        _refreshUserReportok();
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
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            // border: Border.all(color: const Color.fromRGBO(82, 183, 136, 0.5)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.green[200]!),
              columnSpacing: 16,
              dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.green[100]!),
              columns: const [
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Email',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Ward no',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Details',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: userReportslist?.map((user) {
                    return DataRow(cells: [
                      DataCell(Text(user['name'] ?? '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(user['email'] ?? '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(user['wardno'].toString(),
                          style: const TextStyle(color: Colors.black))),
                      DataCell(Text(user['details'] ?? '',
                          style: const TextStyle(color: Colors.black))),
                      DataCell(
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[600],
                          ),
                          onPressed: () {
                            deleteUserReports(user['id']!);
                          },
                        ),
                      ),
                    ]);
                  }).toList() ??
                  [],
            ),
          ),
        ));
  }
}

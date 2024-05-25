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

class StaffGetUsers extends StatefulWidget {
  // final int? wardno;

  const StaffGetUsers({super.key});

  @override
  State<StaffGetUsers> createState() => _StaffGetUsersState();
}

class _StaffGetUsersState extends State<StaffGetUsers> {
  int wardno = 0;
  List<dynamic> userList = [];

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
      fetchUserByWard(wardno); // Corrected: parse wardno to int
    });
  }

  Future<void> fetchUserByWard(int wardno) async {
    try {
      userList.clear();

      final response =
          await http.get(Uri.parse('$baseUrl$getUserByWard?wardno=$wardno'));
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
                    "Registered Users of ward: $wardno",
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
              _buildDetailsBox(userList),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailsBox(List<dynamic>? userListOk) {
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
              'Location',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'House no',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Phone',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),

          // DataColumn(
          //   label: Text(
          //     'Date',
          //     style:
          //         TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          //   ),
          // ),
        ],
        rows: userListOk?.map((usersOk) {
              return DataRow(cells: [
                DataCell(Text(usersOk['name'] ?? '',
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(usersOk['email'] ?? '',
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(usersOk['location'],
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(usersOk['houseno'],
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(usersOk['phone'],
                    style: const TextStyle(color: Colors.black))),
              ]);
            }).toList() ??
            [],
      ),
    ),
  );
}

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;

class GetAllUsers extends StatefulWidget {
  const GetAllUsers({super.key});

  @override
  State<GetAllUsers> createState() => _GetAllUsersState();
}

late Future<List<dynamic>> _futureUsers;

class _GetAllUsersState extends State<GetAllUsers> {
  @override
  void initState() {
    super.initState();
    _futureUsers = fetchUsers();
  }

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl + getUser));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminAppBarWithDrawer(
      title: 'USER',
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "USERS",
                    style: kBodyText2.copyWith(
                        color: const Color(0xFF365307), letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder<List<dynamic>>(
                future: _futureUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return _buildDetailsBox(snapshot.data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailsBox(List<dynamic>? users) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(82, 183, 136, 0.5),
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
        columns: [
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
              'Role',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Verified',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
        rows: users?.map((user) {
              return DataRow(cells: [
                DataCell(Text(user['name'] ?? '',
                    style: TextStyle(color: Colors.black))),
                DataCell(Text(user['email'] ?? '',
                    style: TextStyle(color: Colors.black))),
                DataCell(Text(user['role'] ?? '',
                    style: TextStyle(color: Colors.black))),
                DataCell(
                  Text(
                    user['is_Verified'] == 1 ? 'Yes' : 'No',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]);
            }).toList() ??
            [],
      ),
    ),
  );
}

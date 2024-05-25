// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/admin_main/adminHomepage/adminHomepage.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/Staff_and_users_Reports/admin_get_staff_bulk_report/admin_get_bulk_report.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/Staff_and_users_Reports/admin_get_user_report/admin_get_user_report.dart';

import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/presentation/screens/user_main/userHomepage/userHomepage.dart';
import 'package:finalyear/utils/urls.dart';

import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class StaffAndUserReport extends StatefulWidget {
  const StaffAndUserReport({Key? key}) : super(key: key);

  @override
  State<StaffAndUserReport> createState() => _StaffAndUserReportState();
}

class _StaffAndUserReportState extends State<StaffAndUserReport> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserHomePage()),
        );
        return true; // Return true to allow the back navigation
      },
      child: UserAppBarWithDrawer(
        title: 'ADMIN',
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.h),
          child: DefaultTabController(
            length: 2, // Define the number of tabs
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {},
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.black),
                            onPressed: () {
                              Navigator.pushReplacement(context,
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
                          "Staff and User Report",
                          style: kBodyText2.copyWith(
                            color: const Color(0xFF365307),
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      // TabBar
                      const TabBar(
                        tabs: [
                          Tab(text: 'Staff Bulk Report'),
                          Tab(text: 'User Report'),
                        ],
                      ),
                      // TabBarView
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: const TabBarView(
                          children: [
                            AdminGetStaffBulkReport(),
                            AdminGetUserReport(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

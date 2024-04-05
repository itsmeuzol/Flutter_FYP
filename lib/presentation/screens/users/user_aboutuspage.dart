// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/addStaff/addStaffRepository/addStaffRepository.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/presentation/screens/user_main/userHomepage/userHomepage.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:http/http.dart' as http;

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  // List<AddStaff> addstaff = []; // Define addstaff list here

  TextEditingController locationController = TextEditingController();
  TextEditingController wardnoController = TextEditingController();
  TextEditingController filterWardController = TextEditingController();
  TextEditingController reportdetailsCOntroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeydrpdwn = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, String>> staffList = []; // Store staff details acc to ward

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshStaffMembers() async {}

  @override
  void dispose() {
    locationController.dispose();
    wardnoController.dispose();

    super.dispose();
  }

//

  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserHomePage()),
        );
        return true; // Return true to allow the back navigation
      },
      child: UserAppBarWithDrawer(
        title: 'USER',
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.h),
                      child: Text(
                        "About us",
                        style: kBodyText2.copyWith(
                          fontSize: 14.sp,
                          color: const Color(0xFF365307),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  Text(
                      """ Welcome to SafaSahar Waste Management System, where innovation meets sustainability. We're dedicated to transforming waste management practices for cleaner communities and a healthier planet.
              
Through advanced technology and community engagement, we streamline waste collection, sorting, and processing to minimize landfill waste and maximize resource recovery.
              
Join us in our mission to create a greener future. Together, we can make a lasting impact on our environment and build sustainable communities""")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

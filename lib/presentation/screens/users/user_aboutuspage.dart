// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/addStaff/addStaffRepository/addStaffRepository.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
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
      onWillPop: () async => false,
      child: UserAppBarWithDrawer(
        title: 'USER',
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "About us",
                      style: kBodyText2.copyWith(
                        color: const Color(0xFF365307),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

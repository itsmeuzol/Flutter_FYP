import 'package:finalyear/components/constants.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                    "PROFILE",
                    style: kBodyText2.copyWith(
                        color: const Color(0xFF365307), letterSpacing: 1),
                  ),
                ),
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/user.jpg'),
              ),
              Text(
                "fname lname",
                style: kHeadline.copyWith(fontSize: 18.sp),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  children: [Text("Basic Details")],
                ),
              ),
              SizedBox(
                  height: 10), // Add space between "Basic Details" and the box
              _buildDetailsBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(82, 183, 136, 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Name", "fghjsd fdghjsds"),
          _buildDetailRow("Address", "fghjsdsdk"),
          _buildDetailRow("Email", "fghjk@sdfgh.com"),
          _buildDetailRow("Phone", "9876543210"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
            ),
            child: Text(
              "$label: ",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16.sp, letterSpacing: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

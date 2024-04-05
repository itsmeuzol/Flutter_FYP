import 'package:finalyear/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildActiveUsersWidget(String activeUsersText, int totalUsers) {
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
                  color: Color(0xFF003E1F),
                  fontWeight: FontWeight.w500,
                )),
            Text("TOTAL: $totalUsers",
                style: kBodyText.copyWith(
                  color: Color(0xFF003E1F),
                  fontWeight: FontWeight.w500,
                ))
          ],
        ),
      ),
    ),
  );
}

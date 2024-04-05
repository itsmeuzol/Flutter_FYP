import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget builddustbinbox({
  String? count,
  required String title,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 65.h,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.r)),
      color: const Color(0xFF52B788),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                'Total: $count',
                style: TextStyle(fontSize: 15.sp),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

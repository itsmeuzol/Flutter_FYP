import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String googleApiKey = "AIzaSyD9GUN6NoQ_ldV5gTWSsKsfAjwJ61Xbq7Q";

// Colors
const kBackgroundColor = Color(0xff191720);
const kTextFieldFill = Color(0xff1E1C24);
// TextStyles
var kHeadline = TextStyle(
  color: Colors.black87,
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
);

var kBodyText = TextStyle(
    color: Colors.black87, fontSize: 12.sp, fontWeight: FontWeight.w500);

var kBodyText3 = TextStyle(
    color: Colors.black87, fontSize: 16.sp, fontWeight: FontWeight.w500);
var kButtonText = TextStyle(
  color: Colors.black87,
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
);

const kBodyText2 =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87);

const subhead = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

InputDecoration kTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: const EdgeInsets.all(16),
  hintStyle: const TextStyle(fontSize: 20),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromRGBO(82, 183, 136, 2),
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromRGBO(82, 183, 136, 2),
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
);

class Validator {
  static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}

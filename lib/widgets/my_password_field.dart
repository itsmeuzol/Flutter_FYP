import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/constants.dart';

// class MyPasswordField extends StatelessWidget {
//   const MyPasswordField({
//     required this.isPasswordVisible,
//     required this.onTap,
//     required this.controller,
//     String? errorText,
//   });
//   final TextEditingController controller;

//   final bool isPasswordVisible;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: TextFormField(
//         style: kBodyText.copyWith(
//             // color: Colors.black,
//             ),
//         obscureText: isPasswordVisible,
//         keyboardType: TextInputType.text,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           suffixIcon: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0.w),
//             child: IconButton(
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               onPressed: onTap,
//               icon: Icon(
//                 isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                 // color: Colors.black,
//               ),
//             ),
//           ),
//           contentPadding: EdgeInsets.all(16.h),
//           hintText: 'Password',
//           hintStyle: kBodyText,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: const Color.fromRGBO(82, 183, 136, 2),
//               width: 1.5.w,
//             ),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: const Color.fromRGBO(82, 183, 136, 2),
//               width: 1.5.w,
//             ),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyPasswordField extends StatelessWidget {
  const MyPasswordField({
    super.key,
    required this.isPasswordVisible,
    required this.onTap,
    this.validator,
    // required this.formKey,
    required this.controller,
    String? errorText,
  });

  final TextEditingController controller;
  final bool isPasswordVisible;
  final FormFieldValidator<String>? validator;
  // final GlobalKey<FormState> formKey;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        validator: validator,

        // key: key, // Assign the provided key
        style: kBodyText,
        obscureText: isPasswordVisible, // Invert obscureText value
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: onTap,
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(14.h),
          hintText: 'Password',
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromRGBO(82, 183, 136, 2),
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromRGBO(82, 183, 136, 2),
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onChanged: (value) {
          print('Password changed: $value');
        },
        controller: controller, // Assign the provided controller
      ),
    );
  }
}

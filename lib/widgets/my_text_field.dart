import 'package:finalyear/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyTextField extends StatelessWidget {
//   const MyTextField({
//     super.key,
//     required this.hintText,
//     required this.inputType,
//     this.controller,
//     this.validator,
//     required this.formKey,
//     this.showDropdownIcon = false,
//     this.onDropdownPressed,
//     required this.isEditable,
//     required Null Function(dynamic value)
//         onChanged, // Optional parameter to control visibility of dropdown icon
//   });

//   final String hintText;
//   final TextInputType inputType;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final GlobalKey<FormState> formKey;
//   final bool showDropdownIcon;
//   final VoidCallback? onDropdownPressed;
//   final bool
//       isEditable; // Flag to determine whether to show dropdown icon or not

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       child: Stack(
//         alignment: Alignment.centerRight,
//         children: [
//           TextFormField(
//             controller: controller,
//             keyboardType: inputType,
//             validator: validator,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             textInputAction: TextInputAction.next,
//             readOnly: !isEditable,
//             decoration: InputDecoration(
//               fillColor: Colors.white,
//               filled: true,
//               contentPadding: EdgeInsets.all(16.h),
//               hintText: hintText,
//               hintStyle: kBodyText,
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: const Color.fromRGBO(82, 183, 136, 2),
//                   width: 1.5.w,
//                 ),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: const Color.fromRGBO(82, 183, 136, 2),
//                   width: 1.5.w,
//                 ),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               suffixIcon: showDropdownIcon
//                   ? IconButton(
//                       icon: const Icon(Icons.arrow_drop_down),
//                       onPressed: onDropdownPressed,
//                     )
//                   : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class MyTextField extends StatefulWidget {
  const MyTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    this.controller,
    this.validator,
    this.formKey,
    this.showDropdownIcon = false,
    this.onDropdownPressed,
    required this.isEditable,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final TextInputType inputType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final GlobalKey<FormState>? formKey;
  final bool showDropdownIcon;
  final VoidCallback? onDropdownPressed;
  final bool isEditable;
  final ValueChanged<String> onChanged;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            autovalidateMode: AutovalidateMode
                .onUserInteraction, // Set auto-validation mode here
            textInputAction: TextInputAction.next,
            readOnly: !widget.isEditable,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(12.h),
              hintText: widget.hintText,
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
              suffixIcon: widget.showDropdownIcon
                  ? IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: widget.onDropdownPressed,
                    )
                  : null,
            ),
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}

class MyTextField2 extends StatelessWidget {
  const MyTextField2({
    super.key,
    required this.hintText,
    required this.inputType,
    this.controller,
    this.validator,
    required this.formKey,
    required Null Function(dynamic value)
        onChanged, // Optional parameter to control visibility of dropdown icon
  });

  final String hintText;
  final TextInputType inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: inputType,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(16.h),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black87, fontSize: 14.sp),
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
          ),
        ],
      ),
    );
  }
}

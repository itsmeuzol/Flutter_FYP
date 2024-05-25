import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final Widget icon;
  final bool isPassword;
  final TextEditingController controller;

  final String? Function(String?) validator;

  const InputField({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    required this.validator,
    super.key,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 20.w,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: const Color(0xFF333333),
        ),
        errorStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 20.w,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: 30.w,
          ),
          child: widget.isPassword
              ? GestureDetector(
                  child: hide
                      ? Semantics(
                          label: "Show Password",
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 20,
                            color: Colors.green,
                          ),
                        )
                      : Semantics(
                          label: "Hide Password",
                          child: SvgPicture.asset(
                            'assets/icons/eye_close.svg',
                            width: 20.w,
                            color: Colors.green,
                          ),
                        ),
                  onTap: () {
                    setState(() {
                      hide = !hide;
                    });
                  },
                )
              : widget.icon,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
      ),
    );
  }
}

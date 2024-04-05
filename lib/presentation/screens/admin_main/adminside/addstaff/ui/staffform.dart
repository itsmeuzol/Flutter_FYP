// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:finalyear/components/constants.dart';
// import 'package:finalyear/screens/signup/widgets/methods.dart';
// import 'package:finalyear/widgets/my_text_button.dart';
// import 'package:finalyear/widgets/my_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class StaffForm extends StatefulWidget {
//   const StaffForm({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _StaffFormState createState() => _StaffFormState();
// }

// class _StaffFormState extends State<StaffForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _locationController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Name",
//             style: kBodyText.copyWith(fontSize: 15.sp),
//           ),
//           MyTextField(
//             hintText: "Name..",
//             inputType: TextInputType.text,
//             formKey: _formKey,
//             isEditable: true,
//             onChanged: (value) {},
//           ),
//           Text(
//             "Location",
//             style: kBodyText.copyWith(fontSize: 15.sp),
//           ),
//           MyTextField(
//             hintText: 'Location',
//             controller: _locationController,
//             inputType: TextInputType.text,
//             onDropdownPressed: () {
//               location(context, _locationController);
//             },
//             formKey: _formKey,
//             showDropdownIcon: true,
//             isEditable: false,
//             onChanged: (value) {},
//           ),
//           Text(
//             "Number",
//             style: kBodyText.copyWith(fontSize: 15.sp),
//           ),
//           MyTextField(
//             hintText: "Number..",
//             inputType: TextInputType.text,
//             formKey: _formKey,
//             isEditable: true,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter a number';
//               }
//               if (int.tryParse(value) == null) {
//                 return 'Please enter a valid integer';
//               }
//               return null;
//             },
//             onChanged: (value) {},
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 10.h),
//             child: MyTextButton(
//               buttonName: 'Add',
//               onPressed: () {},
//               bgColor: const Color(0xFF0D9752),
//               textColor: Colors.black,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/widgets/my_text_button.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddTextfield extends StatefulWidget {
  String name;
  final String hintTextName;
  final String validatorText;

  CustomAddTextfield({
    super.key,
    required this.name,
    required this.hintTextName,
    required this.validatorText,
    required controller,
  });

  @override
  _CustomAddTextfieldState createState() => _CustomAddTextfieldState();
}

class _CustomAddTextfieldState extends State<CustomAddTextfield> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name, style: kBodyText),
          MyTextField(
            hintText: widget.hintTextName,
            inputType: TextInputType.text,
            formKey: _formKey,
            isEditable: true,
            controller: _textController,
            onChanged: (value) {},
            validator: (name) => name!.isEmpty ? widget.validatorText : null,
          ),
        ],
      ),
    );
  }
}

class CustomAddButton extends StatefulWidget {
  final String name;
  final Function onPressed;
  const CustomAddButton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  State<CustomAddButton> createState() => _CustomAddButtonState();
}

class _CustomAddButtonState extends State<CustomAddButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: MyTextButton(
        buttonName: widget.name,
        onPressed: () {
          // Call the onPressed function when the button is pressed
          widget.onPressed();
        },
        bgColor: const Color(0xFF0D9752),
        textColor: Colors.black,
      ),
    );
  }
}

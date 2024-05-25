// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:finalyear/components/constants.dart';

import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/presentation/screens/user_main/userHomepage/userHomepage.dart';
import 'package:finalyear/utils/urls.dart';

import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class StaffBulkRequest extends StatefulWidget {
  const StaffBulkRequest({super.key});

  @override
  State<StaffBulkRequest> createState() => _StaffBulkRequestState();
}

class _StaffBulkRequestState extends State<StaffBulkRequest> {
  TextEditingController locationController = TextEditingController();
  TextEditingController filterLocationController = TextEditingController();

  TextEditingController wardnoController = TextEditingController();
  TextEditingController filterWardController = TextEditingController();
  TextEditingController reportdetailsController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String name = '';
  String email = '';

  XFile? pickedImage;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> selectedImages = [];

  @override
  void dispose() {
    locationController.dispose();
    wardnoController.dispose();
    filterWardController.dispose();
    filterLocationController.dispose();
    reportdetailsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? '';
      email = prefs.getString('user_email') ?? '';
    });
  }

  void pickImage() async {
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        this.pickedImage = pickedImage;
      });
    } else {
      print("No images selected");
    }
  }

  void _showImageDialog(XFile image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.file(File(image.path)),
        );
      },
    );
  }

  void toggleImage(XFile image) {
    if (selectedImages.contains(image)) {
      setState(() {
        selectedImages.remove(image);
      });
    } else {
      setState(() {
        selectedImages.add(image);
      });
    }
  }

  Future<void> submitReport() async {
    if (formKey.currentState!.validate()) {
      if (filterWardController.text.isNotEmpty &&
          filterLocationController.text.isNotEmpty &&
          reportdetailsController.text.isNotEmpty) {
        // Prepare report data
        String wardno = filterWardController.text;
        String location = filterLocationController.text;
        String message = reportdetailsController.text;

        // Construct the request body
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(baseUrl + createBulkRequest), // Adjust the URL
        );

        request.fields['wardno'] = wardno;
        request.fields['location'] = location;
        request.fields['message'] = message;

        // Attach images
        for (XFile image in selectedImages) {
          var stream = http.ByteStream(image.openRead());
          var length = await image.length();

          var multipartFile = http.MultipartFile(
            'image',
            stream,
            length,
            filename: image.path.split('/').last,
          );

          request.files.add(multipartFile);
        }

        // Send the request
        var response = await request.send();

        if (response.statusCode == 200) {
          print('Report submitted successfully');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Report submitted successfully')),
          );
        } else {
          print('Failed to submit report');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to submit report')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
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
        title: 'STAFF',
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {},
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(Icons.arrow_back, color: Colors.black),
                  //       onPressed: () {
                  //         Navigator.pushReplacement(context,
                  //             MaterialPageRoute(builder: (context) {
                  //           return StaffHomePage();
                  //         }));
                  //       },
                  //     )
                  //   ],
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Staff Bulk Request",
                        style: kBodyText2.copyWith(
                          color: const Color(0xFF365307),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(82, 183, 136, 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Ward no:", style: kHeadline),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: MyTextField(
                                    hintText: 'Ward no...',
                                    controller: filterWardController,
                                    inputType: TextInputType.text,
                                    onDropdownPressed: () {
                                      wardno(context, filterWardController);
                                    },
                                    // formKey: formKeydrpdwn,
                                    showDropdownIcon: true,
                                    validator: (name) => name!.isEmpty
                                        ? 'Please select your ward'
                                        : null,
                                    isEditable: false,
                                    onChanged: (value) {
                                      // Update locationController when location is selected
                                      filterWardController.text = value;
                                      print(
                                          "filterwardController: ${filterWardController.text}");
                                    },
                                  ),
                                ),

                                //

                                Text("Select Location:", style: kHeadline),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: MyTextField(
                                    hintText: 'Location...',
                                    controller: filterLocationController,
                                    inputType: TextInputType.text,
                                    onDropdownPressed: () {
                                      location(
                                          context, filterLocationController);
                                    },
                                    // formKey: formKeydrpdwn,
                                    showDropdownIcon: true,
                                    validator: (name) => name!.isEmpty
                                        ? 'Please select your location'
                                        : null,
                                    isEditable: false,
                                    onChanged: (value) {
                                      // Update locationController when location is selected
                                      filterLocationController.text = value;
                                      print(
                                          "filterLocationController: ${filterLocationController.text}");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                          child: const Row(
                            children: [
                              Text(
                                "Request",
                                style: subhead,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.h, vertical: 5.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(82, 183, 136, 0.5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            height: 130.h,
                            width: double.maxFinite,
                            // color: const Color.fromRGBO(82, 183, 136, 0.5),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 11.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                ),
                                height: double.infinity,
                                child: TextField(
                                  controller: reportdetailsController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Type here...',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Container for displaying the picked image
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.h, vertical: 5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Add Photo button
                              CustomAddButton(
                                name: "Add photo or image from gallery",
                                onPressed: () async {
                                  final XFile? image = await imagePicker
                                      .pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    toggleImage(image);
                                  } else {
                                    print("No image selected");
                                  }
                                },
                              ),
                              SizedBox(
                                  height: 10
                                      .h), // Add spacing between buttons and selected images
                              // Display selected images with cancel icon
                              Wrap(
                                children: selectedImages.map((image) {
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showImageDialog(
                                              image); // Show the image in a dialog when tapped
                                        },
                                        child: Container(
                                          height: 50.h,
                                          width: 50.w,
                                          margin: EdgeInsets.only(right: 10.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image:
                                                  FileImage(File(image.path)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            toggleImage(image);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                              size: 18.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        CustomAddButton(
                            name: "Make a request",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                submitReport();
                                wardnoController.clear();
                                reportdetailsController.clear();
                                selectedImages.clear();
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

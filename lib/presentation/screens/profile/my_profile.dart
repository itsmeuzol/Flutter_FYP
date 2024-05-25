import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/user_main/userHomepage/userHomepage.dart';
import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:finalyear/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String name = '';
  String email = '';
  String phone = '';
  String location = '';
  int wardno = 0;
  File? _image;
  @override
  void initState() {
    super.initState();
    getUserData(); // Call a method to retrieve user data from SharedPreferences
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve user data from SharedPreferences
      name = prefs.getString('user_name') ?? '';
      email = prefs.getString('user_email') ?? '';
      phone = prefs.getString('phone') ?? '';
      location = prefs.getString('location') ?? '';
    });
  }

  Future<void> _showImagePicker(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadProfileImage(File imageFile, String userId) async {
    final uri = Uri.parse('http://localhost:3000/upload-profile');
    final request = http.MultipartRequest('POST', uri);
    request.fields['userId'] = userId;
    request.files.add(http.MultipartFile('profileImage',
        imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
        filename: imageFile.path.split('/').last));

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Profile image uploaded successfully');
    } else {
      print('Failed to upload profile image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return UserAppBarWithDrawer(
      title: 'USER',
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomBackIcon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const UserHomePage();
                      }));
                    },
                  )
                ],
              ),
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
              GestureDetector(
                onTap: () {
                  _showImagePicker(context);
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/images/user.jpg')
                          as ImageProvider<Object>,
                  child: _image == null ? const Icon(Icons.camera_alt) : null,
                ),
              ),
              Text(
                name,
                style: kHeadline.copyWith(fontSize: 18.sp),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: const Row(
                  children: [Text("Basic Details")],
                ),
              ),
              const SizedBox(
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(82, 183, 136, 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Name", name),
          _buildDetailRow("Address", location),
          _buildDetailRow("Email", email),
          _buildDetailRow("Phone", phone),
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

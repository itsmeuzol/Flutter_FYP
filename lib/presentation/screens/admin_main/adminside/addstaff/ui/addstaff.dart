// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/addStaff/addStaffRepository/addStaffRepository.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:http/http.dart' as http;

class AdminAddStaff extends StatefulWidget {
  const AdminAddStaff({super.key});

  @override
  State<AdminAddStaff> createState() => _AdminAddStaffState();
}

class _AdminAddStaffState extends State<AdminAddStaff> {
  // List<AddStaff> addstaff = []; // Define addstaff list here

  TextEditingController locationController = TextEditingController();
  TextEditingController filterWardController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  TextEditingController housenoController = TextEditingController();
  TextEditingController wardnoController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeydrpdwn = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, String>> staffList = []; // Store staff details acc to ward

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    // addstaff = [];
    // _fetchStaffMembersok();
  }

  // Future<void> _fetchStaffMembersok() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     // Make API call to fetch staff members
  //     final List<AddStaff> staffMembers =
  //         // await StaffRepository().fetchStaffMembers();
  //         await StaffRepository()
  //             .fetchStaffMembers(page: _page, pageSize: _pageSize);

  //     setState(() {
  //       // addstaff = staffMembers;
  //       addstaff.addAll(staffMembers);
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error fetching staff members: $e');
  //     // Handle error
  //     // Handle error
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _loadMoreStaffMembers() async {
  //   // Increment the page number to fetch the next page of staff members
  //   _page++;
  //   await _fetchStaffMembersok();
  // }

  // Future<void> _refreshStaffMembers() async {
  //   setState(() {
  //     // addstaff.clear();
  //   });
  //   await _fetchStaffMembersok();
  // }

  // just to run
  Future<void> _refreshStaffMembers() async {
    //   setState(() {
    //     // addstaff.clear();
    //   });
    //   await _fetchStaffMembersok();
  }

  @override
  void dispose() {
    locationController.dispose();
    wardnoController.dispose();
    housenoController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();

    super.dispose();
  }

// Create a method to validate the filter section
  // void _validateFilterSection() {
  //   if (formKeydrpdwn.currentState!.validate()) {
  //     // Filter section is valid, perform filtering logic here
  //   }
  // }

  _registerStaff() async {
    try {
      // int wardNumber = int.parse(wardnoController.text);
      // print("Parsed ward number: $wardNumber");
      StaffRepository staffRepository = StaffRepository();
      bool isRegister = await staffRepository.register(AddStaffModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: numberController.text,
        location: locationController.text,
        // houseno: 100, //test
        // wardno: 3, //test
        wardno: int.parse(wardnoController.text),
        houseno: int.parse(housenoController.text),

        isAdmin: 0,
        isStaff: 1,
      ));

      if (isRegister) {
        print("Staff addded successfully");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff added successfully")),
        ); // AuthController.login();
      } else {
        throw Exception("Registration failed");
      }
    } catch (e) {
      MotionToast.error(
        height: 50.h,
        width: double.infinity,
        animationDuration: const Duration(milliseconds: 300),
        description: const Text("Something went wrong"),
      ).show(context);
    }
  }

  Future<void> fetchStaffByWard(int ward) async {
    try {
      staffList.clear(); //yo herna parchha

      final response =
          await http.get(Uri.parse(baseUrl + getStaffByWard + '?wardno=$ward'));
      if (response.statusCode == 200) {
        print("staffbyward res");
        final data = jsonDecode(response.body);
        // Extract staff members' names, locations, and emails
        final List<dynamic> staffMembers = data['staffMembers'];

        staffMembers.forEach((staff) {
          final int id = staff['id'];
          final String name = staff['name'];
          final String? location = staff['location'];
          final String? email = staff['email'];
          final int? wardno = staff['wardno'];
          final String? phone = staff['phone'];
          print(
              'ID: $id, Name: $name, Location: $location, Email: $email, Ward: $wardno, Phone:$phone,');
          // Add staff details to the staff list
          staffList.add({
            'Id': id.toString(),
            'Name': name,
            'Location': location!,
            'Email': email!,
            'Ward': wardno.toString(),
            'Phone': phone.toString(),
          });
        });
        setState(() {}); // Notify that the state has changed
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please try again")),
        );
        print('Failed to fetch staff members: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching staff members: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  }

//
//
// edidt staff

  Future<void> editStaff({required int id}) async {
    try {
      final response = await http.patch(
        Uri.parse(baseUrl + editStaffUrl + '?id=$id'),
        body: {
          'name': nameController.text,
          'email': emailController.text,
          'location': locationController.text,
          'ward': wardnoController.text,
          'phone': numberController.text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Staff member updated successfully')),
        );
        _refreshStaffMembersokk();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update staff member')),
        );
      }
    } catch (error) {
      // Handle errors
      print('Error updating staff member: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

//
//
// delete staff
  void deleteStaff(String id) async {
    try {
      final response = await http.delete(
        // Uri.parse('http://192.168.1.74:5000/api/delete-staff/?id=$id'),

        Uri.parse(baseUrl + deleteStaffUrl + '?id=$id')
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Staff member deleted successfully')),
        );
        _refreshStaffMembersokk();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete staff member')),
        );
      }
    } catch (error) {
      // Handle errors
      print('Error deleting staff member: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  Future<void> _refreshStaffMembersokk() async {
    try {
      await fetchStaffByWard(int.parse(filterWardController.text));
    } catch (error) {
      print('Error refreshing staff members: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to refresh staff members")),
      );
    }
  }

  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: AdminAppBarWithDrawer(
        title: 'ADMIN',
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshStaffMembers,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "STAFFS",
                        style: kBodyText2.copyWith(
                            color: const Color(0xFF365307), letterSpacing: 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
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
                                    // validator: (name) => name!.isEmpty
                                    //     ? 'Please select your location'
                                    //     : null,
                                    isEditable: false,
                                    onChanged: (value) {
                                      // Update locationController when location is selected
                                      filterWardController.text = value;
                                      print(
                                          "filterwardController: ${filterWardController.text}");
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        fetchStaffByWard(int.parse(
                                            filterWardController.text));
                                      },
                                      child: Text("Filter")),
                                )
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(height: 15.h),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                          child: const Row(
                            children: [
                              Text(
                                "Staff Details",
                                style: subhead,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.h),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  height: 150.h,
                                  // width: 320.w,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: DataTable(
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                          (states) =>
                                              Color.fromRGBO(82, 183, 136, 0.5),
                                        ),
                                        columnSpacing: 4.w,
                                        columns: const [
                                          DataColumn(label: Text('Id')),
                                          DataColumn(label: Text('Name')),
                                          DataColumn(label: Text('Location')),
                                          DataColumn(label: Text('Email')),
                                          DataColumn(label: Text('Ward')),
                                          DataColumn(label: Text('Phone')),
                                          DataColumn(label: Text('Actions')),
                                        ],
                                        rows: staffList
                                            .map(
                                              (staff) => DataRow(cells: [
                                                DataCell(
                                                    Text(staff['Id'] ?? '')),
                                                DataCell(
                                                    Text(staff['Name'] ?? '')),
                                                DataCell(Text(
                                                    staff['Location'] ?? '')),
                                                DataCell(
                                                    Text(staff['Email'] ?? '')),
                                                DataCell(
                                                    Text(staff['Ward'] ?? '')),
                                                DataCell(
                                                    Text(staff['Phone'] ?? '')),
                                                DataCell(
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Edit Staff'),
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          'Name: ${staff['Name']}'),
                                                                      TextFormField(
                                                                        controller:
                                                                            nameController,
                                                                        decoration:
                                                                            const InputDecoration(labelText: 'New Name'),
                                                                      ),
                                                                      Text(
                                                                          'Email: ${staff['Email']}'),
                                                                      TextFormField(
                                                                        controller:
                                                                            emailController,
                                                                        decoration:
                                                                            const InputDecoration(labelText: 'New Email'),
                                                                      ),
                                                                      Text(
                                                                          'Location: ${staff['Location']}'),
                                                                      TextFormField(
                                                                        controller:
                                                                            locationController,
                                                                        decoration:
                                                                            InputDecoration(labelText: 'New Location'),
                                                                      ),
                                                                      Text(
                                                                          'Ward: ${staff['Ward']}'),
                                                                      TextFormField(
                                                                        controller:
                                                                            wardnoController,
                                                                        decoration:
                                                                            InputDecoration(labelText: 'New Ward'),
                                                                      ),
                                                                      Text(
                                                                          'Phone: ${staff['Phone']}'),
                                                                      TextFormField(
                                                                        controller:
                                                                            numberController,
                                                                        decoration:
                                                                            InputDecoration(labelText: 'New Phone'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      editStaff(
                                                                        id: int.parse(
                                                                            staff['Id']!),
                                                                        // id: staff[
                                                                        //     'Id']!
                                                                      );
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      nameController
                                                                          .clear();
                                                                      emailController
                                                                          .clear();
                                                                      locationController
                                                                          .clear();
                                                                      wardnoController
                                                                          .clear();
                                                                      numberController
                                                                          .clear();
                                                                    },
                                                                    child: Text(
                                                                        'Save'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color:
                                                              Colors.red[600],
                                                        ),
                                                        onPressed: () {
                                                          deleteStaff(
                                                              staff['Id']!);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 20),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: const Text("Add staff to this ward",
                              style: subhead),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Name...',
                            hintStyle: kBodyText,
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter a name' : null,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: emailController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Email...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an email';
                              } else if (!Validator.isValidEmail(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Password...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a password'
                                : null,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: locationController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Location...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a location'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: wardnoController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Ward Number...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a ward number'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: housenoController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'House Number...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a house number'
                                : null,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Number',
                            //   style: kBodyText,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: TextFormField(
                                controller: numberController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: "Phone Number...",
                                    hintStyle: kBodyText),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a phone number';
                                  } else if (!Validator.isValidPhoneNumber(
                                      value)) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        CustomAddButton(
                          name: "Add",
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (formKey.currentState!.validate()) {
                              _registerStaff();
                              nameController.clear();
                              numberController.clear();
                              locationController.clear();
                              wardnoController.clear();
                              housenoController.clear();
                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Validator {
  static bool isValidEmail(String email) {
    // Regular expression for validating email addresses
    // This regular expression checks for a basic email format with @ and .
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression for validating phone numbers
    // This regular expression checks for a basic phone number format with digits only
    final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }
}

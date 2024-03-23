// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/addStaff/addStaffRepository/addStaffRepository.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbinModel/addDustbinModel.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbinRepository/addDustbinRepository.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:http/http.dart' as http;

class AdminAddDustbin extends StatefulWidget {
  const AdminAddDustbin({super.key});

  @override
  State<AdminAddDustbin> createState() => _AdminAddDustbinState();
}

class _AdminAddDustbinState extends State<AdminAddDustbin> {
  // List<AddStaff> addstaff = []; // Define addstaff list here

  TextEditingController locationController = TextEditingController();
  TextEditingController filterWardController = TextEditingController();

  // TextEditingController dustbinId = TextEditingController();
  TextEditingController assignedStaff = TextEditingController();

  TextEditingController wardnoController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeydrpdwn = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, String>> dustbinList =
      []; // Store dustbin details acc to ward

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
  }

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
    // filterWardController.dispose();
    // dustbinId.dispose();
    assignedStaff.dispose();

    super.dispose();
  }

  _dustbinAdd() async {
    try {
      // int wardNumber = int.parse(wardnoController.text);
      // print("Parsed ward number: $wardNumber");
      DustbinRepository dustbinRepository = DustbinRepository();
      bool isAdded = await dustbinRepository.register(AddDustbinModel(
        location: locationController.text,
        wardno: int.parse(wardnoController.text),
        // assignedStaff: int.parse(assignedStaff.text),
        assigned_staff: 3,
        dustbin_type: "empty",
        fill_percentage: 90,
      ));

      if (isAdded) {
        print("dustbin addded successfully");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Dustbin added successfully")),
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

  Future<void> fetchDustbinByWard(int ward) async {
    try {
      dustbinList.clear(); //yo herna parchha

      final response = await http.get(
          // Uri.parse(
          // 'http://192.168.1.74:5000/api/get-filter-dustbin/?wardno=$ward'));

          Uri.parse(baseUrl + getDustbinByWard + '?wardno=$ward'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> dustbinData = data['data'];

        dustbinData.forEach((dustbin) {
          final int id = dustbin['id'];
          final String? location = dustbin['location'];
          final int? wardno = dustbin['wardno'];
          final int? fill_percentage = dustbin['fill_percentage'];
          final int? assigned_staff = dustbin['assigned_staff'];
          final String? dustbin_type = dustbin['location'];

          print(
              "dustbin id: $id, location: $location, wardno: $wardno, fill_percentage: $fill_percentage, assigned_staff: $assigned_staff, dustbin_type: $dustbin_type");
          // Add staff details to the staff list
          dustbinList.add({
            'id': id.toString(),
            'location': location!,
            'wardno': wardno.toString(),
            'fill_percentage': fill_percentage.toString(),
            'assigned_staff': assigned_staff.toString(),
            'dustbin_type': dustbin_type!,
          });
        });
        setState(() {}); // Notify that the state has changed
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please try again")),
        );
      }
    } catch (error) {
      print('Error fetching dustbins : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  }

  Future<void> _refreshDustbinokk() async {
    try {
      await fetchDustbinByWard(int.parse(filterWardController.text));
    } catch (error) {
      print('Error refreshing staff members: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to refresh staff members")),
      );
    }
  }

  Future<void> editDustbin({required int id}) async {
    try {
      final response = await http.patch(
        Uri.parse(baseUrl + editDustbinUrl + '?id=$id'),
        body: {
          'location': locationController.text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dustbin updated successfully')),
        );
        _refreshDustbinokk();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update dustbin')),
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

//delete dustbin
  void deleteDustbin(String id) async {
    try {
      final response =
          await http.delete(Uri.parse(baseUrl + deleteDustbinUrl + '?id=$id'));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dustbin deleted successfully')),
        );
        _refreshDustbinokk();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete dustbin')),
        );
      }
    } catch (error) {
      // Handle errors
      print('Error deleting dustbin: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
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
                        "DUSTBINS",
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
                                        fetchDustbinByWard(int.parse(
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
                                "Dustbin Details",
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
                                          DataColumn(label: Text('Dustbin Id')),
                                          DataColumn(label: Text('Location')),
                                          DataColumn(
                                              label: Text('Fill Precentage')),
                                          DataColumn(
                                              label: Text('Assigned Staff')),
                                          DataColumn(label: Text('Action')),
                                        ],
                                        rows: dustbinList
                                            .map(
                                              (dustbin) => DataRow(cells: [
                                                DataCell(
                                                    Text(dustbin['id'] ?? '')),
                                                DataCell(Text(
                                                    dustbin['location'] ?? '')),
                                                DataCell(Text(dustbin[
                                                        'fill_percentage'] ??
                                                    '')),
                                                DataCell(Text(
                                                    dustbin['assigned_staff'] ??
                                                        '')),
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
                                                                    'Edit Dustbin'),
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          'Location: ${dustbin['location']}'),
                                                                      TextFormField(
                                                                        controller:
                                                                            locationController,
                                                                        decoration:
                                                                            const InputDecoration(labelText: 'New location'),
                                                                      ),
                                                                      Text(
                                                                          'Assigned Staff: ${dustbin['assigned_staff']}'),
                                                                      TextFormField(
                                                                        controller:
                                                                            assignedStaff,
                                                                        decoration:
                                                                            const InputDecoration(labelText: 'New Assigned Staff'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      editDustbin(
                                                                        id: int.parse(
                                                                            dustbin['id']!),
                                                                        // id: staff[
                                                                        //     'Id']!
                                                                      );
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      locationController
                                                                          .clear();
                                                                      assignedStaff
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
                                                          deleteDustbin(
                                                              dustbin['id']!);
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
                          child: const Text("Add Dustbin to this ward",
                              style: subhead),
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
                              hintText: 'Ward no...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a ward no'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: MyTextField(
                            hintText: 'Assigned Staff...',
                            controller: assignedStaff,
                            inputType: TextInputType.text,
                            onDropdownPressed: () {
                              selectAssignedStaff(context, assignedStaff);
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
                              print("assignedstaff: ${assignedStaff.text}");
                            },
                          ),
                        ),

                        CustomAddButton(
                          name: "Add",
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (formKey.currentState!.validate()) {
                              _dustbinAdd();
                              assignedStaff.clear();
                              locationController.clear();
                              wardnoController.clear();
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

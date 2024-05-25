// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
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
  TextEditingController assignedStaffController = TextEditingController();

  TextEditingController wardnoController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeydrpdwn = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, String>> dustbinList =
      []; // Store dustbin details acc to ward

  StaffMember? selectedStaff;

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    // fetchStaffList();
    super.initState();
    // Fetch staff list and assign the result to staffList
    fetchStaffList().then((staff) {
      setState(() {
        staffList = staff;
      });
    }).catchError((error) {
      print('Error fetching staff list: $error');
    });
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

  // _dustbinAdd() async {
  //   try {
  //     // int wardNumber = int.parse(wardnoController.text);
  //     // print("Parsed ward number: $wardNumber");
  //     DustbinRepository dustbinRepository = DustbinRepository();
  //     bool isAdded = await dustbinRepository.register(AddDustbinModel(
  //       location: locationController.text,
  //       wardno: int.parse(wardnoController.text),
  //       assigned_staff: int.parse(assignedStaff.text),
  //       // assigned_staff: 3,
  //       dustbin_type: "full",
  //       fill_percentage: 20,
  //     ));

  //     if (isAdded) {
  //       print("dustbin addded successfully");

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Dustbin added successfully")),
  //       ); // AuthController.login();
  //     } else {
  //       throw Exception("Registration failed");
  //     }
  //   } catch (e) {
  //     MotionToast.error(
  //       height: 50.h,
  //       width: double.infinity,
  //       animationDuration: const Duration(milliseconds: 300),
  //       description: const Text("Something went wrong"),
  //     ).show(context);
  //   }
  // }

  _dustbinAdd() async {
    try {
      DustbinRepository dustbinRepository = DustbinRepository();
      bool isAdded = await dustbinRepository.register(AddDustbinModel(
        location: locationController.text,
        wardno: int.parse(wardnoController.text),
        assigned_staff:
            selectedStaff?.id ?? 0, // Use selected staff's ID if available
        dustbin_type: "full",
        fill_percentage: 20,
      ));

      if (isAdded) {
        print("dustbin added successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Dustbin added successfully")),
        );
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

          Uri.parse('$baseUrl$getDustbinByWard?wardno=$ward'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> dustbinData = data['data'];

        for (var dustbin in dustbinData) {
          final int id = dustbin['id'];
          final String? location = dustbin['location'];
          final int? wardno = dustbin['wardno'];
          final int? fillPercentage = dustbin['fill_percentage'];
          final int? assignedStaff = dustbin['assigned_staff'];
          final String? dustbinType = dustbin['location'];

          print(
              "dustbin id: $id, location: $location, wardno: $wardno, fill_percentage: $fillPercentage, assigned_staff: $assignedStaff, dustbin_type: $dustbinType");
          // Add staff details to the staff list
          dustbinList.add({
            'id': id.toString(),
            'location': location!,
            'wardno': wardno.toString(),
            'fill_percentage': fillPercentage.toString(),
            'assigned_staff': assignedStaff.toString(),
            'dustbin_type': dustbinType!,
          });
        }
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
        Uri.parse('$baseUrl$editDustbinUrl?id=$id'),
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
          await http.delete(Uri.parse('$baseUrl$deleteDustbinUrl?id=$id'));

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

  // List<Map<String, dynamic>> staffList = [];
  // Modify staffList to be a list of StaffMember objects
  // List<StaffMember> staffList = [];
  List<StaffMember> staffList = [];

  // Future<void> fetchStaffList() async {
  //   try {
  //     final response = await http.get(Uri.parse(baseUrl + getStaff));
  //     if (response.statusCode == 200) {
  //       final List<dynamic> staffData = jsonDecode(response.body);
  //       staffList.clear(); // Clear existing staff list
  //       staffData.forEach((staff) {
  //         staffList.add({
  //           'id': staff['id'].toString(),
  //           'name': staff['name'],
  //         });
  //       });
  //       setState(() {}); // Notify that the state has changed
  //     } else {
  //       print('Failed to fetch staff data: ${response.statusCode}');
  //       // Handle error
  //     }
  //   } catch (error) {
  //     print('Error fetching staff data: $error');
  //     // Handle error
  //   }
  // }
  Future<List<StaffMember>> fetchStaffList() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + getStaff));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        final staffData = responseData['staffMembers'] as List<dynamic>;

        final List<StaffMember> staffList = staffData.map((staff) {
          return StaffMember(
            id: staff['id'],
            name: staff['name'],
          );
        }).toList();

        // Assign the populated staffList to the class variable
        setState(() {
          this.staffList = staffList;
        });

        return staffList;
      } else {
        print('Failed to fetch staff data: ${response.statusCode}');
        throw Exception('Failed to fetch staff data');
      }
    } catch (error) {
      print('Error fetching staff data: $error');
      throw Exception('Error fetching staff data');
    }
  }

  @override
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
            physics: const AlwaysScrollableScrollPhysics(),
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
                                      child: const Text("Filter")),
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

                        dustbinList.isEmpty
                            ? Center(
                                child: Text(
                                  'No Dustbins available',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(2.h),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        height: 150.h,
                                        // width: 320.w,
                                        child: Scrollbar(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: DataTable(
                                              headingRowColor:
                                                  MaterialStateColor
                                                      .resolveWith(
                                                (states) =>
                                                    const Color.fromRGBO(
                                                        82, 183, 136, 0.5),
                                              ),
                                              columnSpacing: 4.w,
                                              columns: const [
                                                DataColumn(
                                                    label: Text('Dustbin Id')),
                                                DataColumn(
                                                    label: Text('Location')),
                                                DataColumn(
                                                    label: Text(
                                                        'Fill Precentage')),
                                                // DataColumn(
                                                //     label:
                                                //         Text('Assigned Staff')),
                                                DataColumn(
                                                    label: Text('Action')),
                                              ],
                                              rows: dustbinList.map((dustbin) {
                                                // Find the staff with the same ID as assigned_staff from the staffList
                                                var assignedStaff =
                                                    staffList.firstWhere(
                                                  (staff) =>
                                                      staff.id ==
                                                      dustbin['assigned_staff'],

                                                  // If no matching staff member found, display "Unknown"
                                                  orElse: () => StaffMember(
                                                    id: 0,
                                                    name: 'Unknown',
                                                  ),
                                                );

                                                return DataRow(cells: [
                                                  DataCell(Text(
                                                      dustbin['id'] ?? '')),
                                                  DataCell(Text(
                                                      dustbin['location'] ??
                                                          '')),
                                                  DataCell(Text(dustbin[
                                                          'fill_percentage'] ??
                                                      '')),
                                                  // Display the assigned staff's name
                                                  // DataCell(
                                                  //     Text(assignedStaff.name)),
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
                                                                    child:
                                                                        Column(
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
                                                                            'Assigned Staff: ${assignedStaff.name}'),
                                                                        // TextFormField(
                                                                        //   controller:
                                                                        //       assignedStaffController,
                                                                        //   // Use a separate controller for assigned staff
                                                                        //   decoration:
                                                                        //       const InputDecoration(labelText: 'New Assigned Staff'),
                                                                        // ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 7.h),
                                                                          child:
                                                                              Container(
                                                                            constraints:
                                                                                BoxConstraints(maxHeight: 40.h),
                                                                            child:
                                                                                DropdownButtonFormField<StaffMember>(
                                                                              value: selectedStaff,
                                                                              items: staffList.map((staff) {
                                                                                return DropdownMenuItem<StaffMember>(
                                                                                  value: staff,
                                                                                  child: SizedBox(
                                                                                    height: 40.h,
                                                                                    child: Center(child: Text(staff.name)),
                                                                                  ),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (StaffMember? newValue) {
                                                                                setState(() {
                                                                                  selectedStaff = newValue;
                                                                                });
                                                                              },
                                                                              decoration: InputDecoration(
                                                                                fillColor: Colors.white,
                                                                                filled: true,
                                                                                contentPadding: EdgeInsets.all(12.h),
                                                                                hintText: "Assigned Staff...",
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
                                                                            ),
                                                                          ),
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
                                                                        );
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        locationController
                                                                            .clear();
                                                                        assignedStaffController
                                                                            .clear();
                                                                      },
                                                                      child: const Text(
                                                                          'Save'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
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
                                                ]);
                                              }).toList(),
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
                          child: MyTextField(
                            hintText: 'Location',
                            controller: locationController,
                            inputType: TextInputType.text,
                            onDropdownPressed: () {
                              location(context,
                                  locationController); // Call the _wardno method
                            },
                            // formKey: _formKey,
                            showDropdownIcon: true,
                            // validator: (name) => name!.isEmpty
                            //     ? 'Please enter your location'
                            //     : null,
                            isEditable: false,
                            onChanged: (value) {},
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 0.h),
                          child: MyTextField(
                            hintText: 'Ward no...',
                            controller: wardnoController,
                            inputType: TextInputType.text,
                            onDropdownPressed: () {
                              wardno(context, wardnoController);
                            },
                            // formKey: formKeydrpdwn,
                            showDropdownIcon: true,
                            // validator: (name) => name!.isEmpty
                            //     ? 'Please select your ward'
                            //     : null,
                            isEditable: false,
                            onChanged: (value) {
                              // Update locationController when location is selected
                              wardnoController.text = value;
                              print(
                                  "wardnoController: ${wardnoController.text}");
                            },
                          ),
                          // TextFormField(
                          //   controller: wardnoController,
                          //   decoration: kTextFieldDecoration.copyWith(
                          //     hintText: 'Ward no...',
                          //     hintStyle: kBodyText,
                          //   ),
                          //   validator: (value) => value!.isEmpty
                          //       ? 'Please enter a ward no'
                          //       : null,
                          // ),
                        ),

                        // Padding(
                        //   padding: EdgeInsets.only(top: 1.h),
                        //   child: MyTextField(
                        //     hintText: 'Assigned Staff...',
                        //     controller: assignedStaff,
                        //     inputType: TextInputType.text,
                        //     // onDropdownPressed: () {
                        //     //   selectAssignedStaff(context, assignedStaff);
                        //     // },

                        //     onDropdownPressed: () async {
                        //       Map<String, dynamic>? selectedStaff =
                        //           await selectAssignedStaff(context);
                        //       if (selectedStaff != null) {
                        //         assignedStaff.text = selectedStaff[
                        //             'name']; // Set the selected staff's name to the text field
                        //         // Use the selected staff's ID for further processing (e.g., sending to backend)
                        //         int staffId = selectedStaff['id'];
                        //         print('Selected Staff ID: $staffId');
                        //       }
                        //     },

                        //     // formKey: formKeydrpdwn,
                        //     showDropdownIcon: true,
                        //     // validator: (name) => name!.isEmpty
                        //     //     ? 'Please select your location'
                        //     //     : null,
                        //     isEditable: false,
                        //     onChanged: (value) {
                        //       // Update locationController when location is selected
                        //       filterWardController.text = value;
                        //       print("assignedstaff: ${assignedStaff.text}");
                        //     },
                        //   ),
                        // ),

                        Padding(
                          padding: EdgeInsets.only(top: 7.h),
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 40.h),
                            child: DropdownButtonFormField<StaffMember>(
                              value: selectedStaff,
                              items: staffList.map((staff) {
                                return DropdownMenuItem<StaffMember>(
                                  value: staff,
                                  child: SizedBox(
                                    height: 40
                                        .h, // Match the height with the maximum height
                                    child: Center(child: Text(staff.name)),
                                  ),
                                );
                              }).toList(),
                              onChanged: (StaffMember? newValue) {
                                setState(() {
                                  selectedStaff = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(12.h),
                                hintText: "Assigned Staff...",
                                hintStyle: kBodyText,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        const Color.fromRGBO(82, 183, 136, 2),
                                    width: 1.5.w,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        const Color.fromRGBO(82, 183, 136, 2),
                                    width: 1.5.w,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
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
                              selectedStaff = null;
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

class StaffMember {
  final int id;
  final String name;

  StaffMember({required this.id, required this.name});
}

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/adminNotification/wastepickup/wastepickup.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/adminNotification/wastepickupRepository/wastepickupRepository.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class AdminNotificationPage extends StatefulWidget {
  const AdminNotificationPage({Key? key}) : super(key: key);

  @override
  State<AdminNotificationPage> createState() => _AdminNotificationPageState();
}

class _AdminNotificationPageState extends State<AdminNotificationPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _wardnoController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _pickupTimeController = TextEditingController();
  final TextEditingController _filterWardController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, String>> wastePickuplist =
      []; // Store staff details acc to ward

  @override
  void dispose() {
    _messageController.dispose();
    _locationController.dispose();
    _wardnoController.dispose();
    _streetController.dispose();
    _pickupTimeController.dispose();
    _filterWardController.dispose();
    super.dispose();
  }

  _addWastePickupTime() async {
    try {
      WastepickupRepository wastepickupRepository = WastepickupRepository();
      DateTime pickupTime =
          DateFormat("HH:mm").parse(_pickupTimeController.text);

      bool isRegistered = await wastepickupRepository.register(Wastepickup(
        location: _locationController.text,
        wardno: int.parse(_wardnoController.text),
        street: _streetController.text,
        pickup_time: pickupTime,
        message: _messageController.text,
      ));

      if (isRegistered) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Added successfully")),
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

  Future<void> fetchWastebyWard(int ward) async {
    try {
      wastePickuplist.clear(); //yo herna parchha

      final response = await http
          .get(Uri.parse(baseUrl + getWastepickupTimeByWard + '?wardno=$ward'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Extract staff members' names, locations, and emails
        final List<dynamic> wastedata = data['data'];

        wastedata.forEach((waste) {
          final int id = waste['id'];
          final int wardno = waste['wardno'];
          final String? location = waste['location'];
          final String? street = waste['street'];
          final String? pickupTimeString = waste['pickup_time'];
          final String? message = waste['message'];

          String? formattedPickupTime;
          if (pickupTimeString != null) {
            final DateTime? pickupTime = DateTime.tryParse(pickupTimeString);
            formattedPickupTime = pickupTime?.toString();
          }

          print(
              "Waste pickup time: $formattedPickupTime, Wardno: $wardno, Location: $location, Street: $street, Message: $message");
          // Add staff details to the staff list
          wastePickuplist.add({
            'id': id.toString(),
            'wardno': wardno.toString(),
            'location': location ?? '',
            'street': street ?? '',
            'pickup_time': formattedPickupTime ?? '',
            'message': message ?? '',
          });
        });

        setState(() {}); // Notify that the state has changed
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please try again")),
        );
        print('Failed to fetch waste: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching waste: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  }

  Future<void> _refreshWasteTimesokk() async {
    try {
      await fetchWastebyWard(int.parse(_filterWardController.text));
    } catch (error) {
      print('Error refreshing time: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to refresh")),
      );
    }
  }

  Future<void> editWasteTime({required int id}) async {
    try {
      final response = await http.patch(
        // Uri.parse('http://192.168.1.74:5000/api/edit-staff?id=$id'),
        Uri.parse(baseUrl + editWastepickupTime + '?id=$id'),
        body: {
          'location': _locationController.text,
          'wardno': _wardnoController.text,
          'street': _streetController.text,
          'pickup_time': _pickupTimeController.text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Time updated successfully')),
        );
        _refreshWasteTimesokk();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update')),
        );
      }
    } catch (error) {
      // Handle errors
      print('Error updating : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  void deleteWasteTime(String id) async {
    try {
      final response = await http
          .delete(Uri.parse(baseUrl + deleteWastepickupTime + '?id=$id'));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deleted successfully')),
        );
        _refreshWasteTimesokk();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete')),
        );
      }
    } catch (error) {
      // Handle errors
      print('Error deleting: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AdminAppBarWithDrawer(
        title: 'ADMIN',
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "WASTE PICKUP",
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
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
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
                                  controller: _filterWardController,
                                  inputType: TextInputType.text,
                                  onDropdownPressed: () {
                                    wardno(context, _filterWardController);
                                  },
                                  showDropdownIcon: true,
                                  isEditable: false,
                                  onChanged: (value) {
                                    // Update locationController when location is selected
                                    _filterWardController.text = value;
                                    print(
                                        "filterwardController: ${_filterWardController.text}");
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    fetchWastebyWard(
                                        int.parse(_filterWardController.text));
                                  },
                                  child: Text("Filter"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          children: [
                            Text(
                              "Add Schedule",
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
                                        // DataColumn(label: Text('Id')),
                                        DataColumn(label: Text('Location')),
                                        DataColumn(label: Text('Ward')),
                                        DataColumn(label: Text('Street')),
                                        DataColumn(label: Text('Pickup time')),
                                        DataColumn(label: Text('Actions')),
                                      ],
                                      rows: wastePickuplist
                                          .map(
                                            (waste) => DataRow(cells: [
                                              // DataCell(
                                              // Text(waste['id'] ?? '')),
                                              DataCell(Text(
                                                  waste['location'] ?? '')),
                                              DataCell(
                                                  Text(waste['wardno'] ?? '')),
                                              DataCell(
                                                  Text(waste['street'] ?? '')),
                                              DataCell(Text(
                                                  waste['pickup_time'] ?? '')),

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
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Edit'),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Location: ${waste['location']}'),
                                                                    TextFormField(
                                                                      controller:
                                                                          _locationController,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                              labelText: 'New Location'),
                                                                    ),
                                                                    Text(
                                                                        'Ward no: ${waste['ward_no']}'),
                                                                    TextFormField(
                                                                      controller:
                                                                          _wardnoController,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                              labelText: 'New Ward no'),
                                                                    ),
                                                                    Text(
                                                                        'Street: ${waste['street']}'),
                                                                    TextFormField(
                                                                      controller:
                                                                          _streetController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                              labelText: 'New Street'),
                                                                    ),
                                                                    Text(
                                                                        'Pickup Time: ${waste['pickup_timme']}'),
                                                                    TextFormField(
                                                                      controller:
                                                                          _pickupTimeController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                              labelText: 'New Pickup time'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    editWasteTime(
                                                                      id: int.parse(
                                                                          waste[
                                                                              'id']!),
                                                                      // id: staff[
                                                                      //     'Id']!
                                                                    );
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    _locationController
                                                                        .clear();
                                                                    _wardnoController
                                                                        .clear();
                                                                    _streetController
                                                                        .clear();
                                                                    _pickupTimeController
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
                                                        color: Colors.red[600],
                                                      ),
                                                      onPressed: () {
                                                        deleteWasteTime(
                                                            waste['id']!);
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
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  child: Column(
                    children: [
                      Container(
                        // height: 225.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(82, 183, 136, 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _wardnoController,
                                decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Ward...',
                                  hintStyle: kBodyText,
                                ),
                                // formKey: formKey!,
                                validator: (name) => name!.isEmpty
                                    ? 'Please enter your ward'
                                    : null,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: TextFormField(
                                  controller: _locationController,
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Location...',
                                    hintStyle: kBodyText,
                                  ),
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your location'
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: TextFormField(
                                  controller: _streetController,
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Street...',
                                    hintStyle: kBodyText,
                                  ),
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your street'
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: TextFormField(
                                  controller: _pickupTimeController,
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Pick up time (HH:MM)...',
                                    hintStyle: kBodyText,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your pickup time';
                                    }

                                    // Check if the entered value matches the expected date format "YYYY-MM-DD"
                                    if (!RegExp(r'^\d{2}:\d{2}$')
                                        .hasMatch(value)) {
                                      return 'Invalid time format. Please use HH:MM format';
                                    }

                                    // Validation passed
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      Row(
                        children: [
                          Text(
                            "Other updates",
                            style: subhead,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
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
                          controller: _messageController,
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
                  child: CustomAddButton(
                      name: "Publish",
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        if (_formKey.currentState!.validate()) {
                          _addWastePickupTime();
                          _locationController.clear();
                          _wardnoController.clear();
                          _streetController.clear();
                          _pickupTimeController.clear();
                          _messageController.clear();
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

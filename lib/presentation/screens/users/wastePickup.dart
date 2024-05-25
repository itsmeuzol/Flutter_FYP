// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserWastePickup extends StatefulWidget {
  const UserWastePickup({super.key});

  @override
  State<UserWastePickup> createState() => _UserWastePickupState();
}

class _UserWastePickupState extends State<UserWastePickup> {
  // List<AddStaff> addstaff = []; // Define addstaff list here

  TextEditingController locationController = TextEditingController();
  TextEditingController wardnoController = TextEditingController();
  TextEditingController filterWardController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeydrpdwn = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, String>> pickUpTimeListAdd =
      []; // Store staff details acc to ward

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshStaffMembers() async {}

  @override
  void dispose() {
    locationController.dispose();
    wardnoController.dispose();

    super.dispose();
  }

  Future<void> fetchTimeByWard(int ward) async {
    try {
      pickUpTimeListAdd.clear(); //yo herna parchha

      final response = await http
          .get(Uri.parse('$baseUrl$getWastepickupTimeByWard?wardno=$ward'));
      if (response.statusCode == 200) {
        print("pickuptime res");
        final data = jsonDecode(response.body);
        // Extract staff members' names, locations, and emails
        final List<dynamic> pickTimeList = data['data'];

        for (var pickUpTime in pickTimeList) {
          final int id = pickUpTime['id'];
          // final String pickupTime = pickUpTime['pickup_time'];
          final String pickupTime = pickUpTime['pickup_time'];
          final formattedPickupTime =
              DateFormat('hh:mm:ss a').format(DateTime.parse(pickupTime));
          final String? location = pickUpTime['location'];
          final String? street = pickUpTime['street'];
          final String? message = pickUpTime['message'];

          print(
              "pickup_time: $pickupTime, location: $location, street: $street, message: $message");
          // Add staff details to the staff list
          pickUpTimeListAdd.add({
            'id': id.toString(),
            'pickup_time': formattedPickupTime,
            'location': location!,
            'street': street!,
            'message': message!,
          });
        }
        setState(() {}); // Notify that the state has changed
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please try again")),
        );
        print('Failed to fetch : ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching  : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  }

//
//

//
//

  Future<void> _refreshPickUpTimesokk() async {
    try {
      await fetchTimeByWard(int.parse(filterWardController.text));
    } catch (error) {
      print('Error refreshing : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to refresh")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: UserAppBarWithDrawer(
        title: 'USER',
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
                        "Waste Pickup Schedule",
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
                                      fetchTimeByWard(
                                          int.parse(filterWardController.text));
                                    },
                                    child: const Text("Filter"),
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
                                "Timings",
                                style: subhead,
                              ),
                            ],
                          ),
                        ),
                        // ListView container starts here

                        pickUpTimeListAdd.isEmpty
                            ? Center(
                                child: Text(
                                  'No pickup times available',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              )
                            : Column(
                                children: pickUpTimeListAdd.map((pickUpTime) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    padding: EdgeInsets.all(20.h),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          82, 183, 136, 0.5),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons
                                                .access_time), // Clock Icon
                                            SizedBox(width: 10.w),
                                            Text(
                                              pickUpTime['pickup_time']!,
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on),
                                            SizedBox(width: 10.w),
                                            Text(
                                              pickUpTime['street']!,
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            const Text(","),
                                            SizedBox(width: 8.w),
                                            Text(
                                              pickUpTime['location']!,
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            const Icon(Icons.message),
                                            SizedBox(width: 10.w),
                                            Flexible(
                                              child: Text(
                                                pickUpTime['message']!,
                                                style:
                                                    TextStyle(fontSize: 16.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),

                        // ListView container ends here
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

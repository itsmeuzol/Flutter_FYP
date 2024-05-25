// ignore_for_file: use_build_context_synchronously


import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/user_main/payment/khalti.dart';
import 'package:finalyear/presentation/screens/user_main/userHomepage/userHomepage.dart';

import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectedPackage = ''; // Variable to store selected package

  // List of available packages with descriptions
  final List<Map<String, dynamic>> packages = [
    {'name': '12 Month Package', 'description': '1500'},
    {'name': '6 Month Package', 'description': '1000'},
    {'name': '3 Month Package', 'description': '500'},
    {'name': '1 Month Package', 'description': '200'},

    // Add more packages as needed
  ];
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        title: 'USER',
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const UserHomePage();
                        }));
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 16.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Payment",
                      style: kBodyText2.copyWith(
                        color: const Color(0xFF365307),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                // Container containing package options
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 15.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: packages.map((package) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom: 10.h), // Add margin between options
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: const Color.fromRGBO(82, 183, 136, 0.5),
                        ),
                        child: RadioListTile<String>(
                          title: Text(
                            package['name'],
                          ),
                          subtitle: Text("Rs ${package['description']}"),
                          value: package['name'],
                          groupValue: selectedPackage,
                          onChanged: (value) {
                            setState(() {
                              selectedPackage = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .trailing, // Align radio to the right
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Payment method selection
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Pay Via:',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Pay button
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                    child: CustomAddButton(
                        name: "Pay via khalti",
                        onPressed: () {
                          if (selectedPackage.isNotEmpty) {
                            String selectedPackageDescription = '';
                            for (var package in packages) {
                              if (package['name'] == selectedPackage) {
                                selectedPackageDescription =
                                    package['description'];
                                break;
                              }
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KhaltiPaymentPage(
                                  amountDescription: selectedPackageDescription,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please select a package before proceeding.'),
                              ),
                            );
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

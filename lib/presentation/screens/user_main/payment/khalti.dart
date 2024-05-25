// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:khalti_flutter/khalti_flutter.dart';

// class KhaltiPaymentPage extends StatefulWidget {
//   final String amountDescription;

//   const KhaltiPaymentPage({Key? key, required this.amountDescription})
//       : super(key: key);

//   @override
//   State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
// }

// class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
//   TextEditingController amountController = TextEditingController();

//   getAmt() {
//     return int.parse(amountController.text) * 100; // Converting to paisa
//   }

//   @override
//   void initState() {
//     super.initState();
//     amountController.text =
//         widget.amountDescription; // Set the amount description as default value
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Khalti Payment Integration'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(15.h),
//         child: ListView(
//           children: [
//             SizedBox(height: 15.h),
//             TextField(
//               controller: amountController,
//               decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Enter Amount To Pay',
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.black),
//                     borderRadius: BorderRadius.all(Radius.circular(8.r)),
//                   ),
//                   focusedBorder: const OutlineInputBorder()),
//             ),
//             const SizedBox(
//               height: 28,
//             ),
//             // For Button
//             MaterialButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.r),
//                     side: const BorderSide(color: Colors.black)),
//                 height: 45.h,
//                 color: const Color(0xFF56328c),
//                 child: Text(
//                   'Pay With Khalti',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 onPressed: () {
//                   KhaltiScope.of(context).pay(
//                     config: PaymentConfig(
//                       amount: getAmt(),
//                       productIdentity: 'waste',
//                       productName: 'Waste Payment',
//                     ),
//                     preferences: [
//                       PaymentPreference.khalti,
//                       // PaymentPreference.eBanking,
//                       // PaymentPreference.mobileBanking,
//                       // PaymentPreference.connectIPS
//                     ],
//                     onSuccess: (su) {
//                       amountController.clear();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Payment successful")),
//                       );
//                     },
//                     onFailure: (fa) {
//                       amountController.clear();

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Payment Failed")),
//                       );
//                     },
//                     onCancel: () {
//                       amountController.clear();

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Payment cancelled")),
//                       );
//                     },
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:finalyear/presentation/screens/user_main/userHomepage/userHomepage.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KhaltiPaymentPage extends StatefulWidget {
  final String amountDescription;

  const KhaltiPaymentPage({super.key, required this.amountDescription});

  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();

  getAmt() {
    return int.parse(amountController.text) * 100; // Converting to paisa
  }

  late SharedPreferences prefs;
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    amountController.text =
        widget.amountDescription; // Set the amount description as default value
    loadSharedPreferences();
  }

  Future<void> loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? '';
      email = prefs.getString('user_email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khalti Payment Integration'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.h),
        child: ListView(
          children: [
            SizedBox(height: 15.h),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Amount To Pay',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  focusedBorder: const OutlineInputBorder()),
            ),
            const SizedBox(
              height: 28,
            ),
            // For Button
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: const BorderSide(color: Colors.black)),
              height: 45.h,
              color: const Color(0xFF56328c),
              child: const Text(
                'Pay With Khalti',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                KhaltiScope.of(context).pay(
                  config: PaymentConfig(
                    amount: getAmt(),
                    productIdentity: 'waste',
                    productName: 'Waste Payment',
                  ),
                  preferences: [
                    PaymentPreference.khalti,
                    // PaymentPreference.eBanking,
                    // PaymentPreference.mobileBanking,
                    // PaymentPreference.connectIPS
                  ],
                  onSuccess: (su) async {
                    amountController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Payment successful")),
                    );

                    // Extract necessary data from the response
                    final transactionToken = su.token;
                    final amount = su.amount;
                    final mobileNo = su.mobile;

                    // Call backend API to create payment record
                    await createPaymentRecord(
                        transactionToken, amount, mobileNo);

                    await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserHomePage()));
                  },
                  onFailure: (fa) {
                    amountController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Payment Failed")),
                    );
                  },
                  onCancel: () {
                    amountController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Payment cancelled")),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createPaymentRecord(
      String transactionToken, int amountInPaisa, String mobileNo) async {
    const url = baseUrl + paymentCreate;
    final headers = <String, String>{'Content-Type': 'application/json'};

    // Convert amount from paisa to rupees
    double amountInRupees = amountInPaisa / 100;

    final body = jsonEncode({
      'name': name,
      'email': email,
      'transaction_token': transactionToken,
      'amount': amountInRupees,
      'mobile_no': mobileNo,
      'date': DateTime.now().toIso8601String(),
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 201) {
        print('Payment record created successfully');
      } else {
        print('Failed to create payment record');
      }
    } catch (e) {
      print('Error creating payment record: $e');
    }
  }
}

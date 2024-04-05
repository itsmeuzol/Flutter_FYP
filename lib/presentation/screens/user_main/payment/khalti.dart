import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiPaymentPage extends StatefulWidget {
  final String amountDescription;

  const KhaltiPaymentPage({Key? key, required this.amountDescription})
      : super(key: key);

  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();

  getAmt() {
    return int.parse(amountController.text) * 100; // Converting to paisa
  }

  @override
  void initState() {
    super.initState();
    amountController.text =
        widget.amountDescription; // Set the amount description as default value
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
                child: Text(
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
                    onSuccess: (su) {
                      amountController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Payment successful")),
                      );
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
                }),
          ],
        ),
      ),
    );
  }
}

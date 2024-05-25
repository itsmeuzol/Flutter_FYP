import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/admin_main/adminHomepage/adminHomepage.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/customBackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PaymentReport extends StatefulWidget {
  const PaymentReport({super.key});

  @override
  State<PaymentReport> createState() => _PaymentReportState();
}

late Future<List<dynamic>> _futurePaymentDetails;

class _PaymentReportState extends State<PaymentReport> {
  @override
  void initState() {
    super.initState();
    _futurePaymentDetails = fetchPaymentDetails();
  }

  Future<List<dynamic>> fetchPaymentDetails() async {
    final response = await http.get(Uri.parse(baseUrl + getPaymentDetails));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminAppBarWithDrawer(
      title: 'ADMIN',
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
                        return const AdminHomePage();
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
                    "Payment Reports",
                    style: kBodyText2.copyWith(
                        color: const Color(0xFF365307), letterSpacing: 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<dynamic>>(
                future: _futurePaymentDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return _buildDetailsBox(snapshot.data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailsBox(List<dynamic>? payementDetails) {
  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(82, 183, 136, 0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.green[200]!),
        columnSpacing: 16,
        dataRowColor:
            MaterialStateColor.resolveWith((states) => Colors.green[100]!),
        columns: const [
          DataColumn(
            label: Text(
              'Name',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Email',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Transaction ID',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Amount',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Mobile No',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          DataColumn(
            label: Text(
              'Date',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
        rows: payementDetails?.map((payment) {
              return DataRow(cells: [
                DataCell(Text(payment['name'] ?? '',
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(payment['email'] ?? '',
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(payment['transaction_token'] ?? '',
                    style: const TextStyle(color: Colors.black))),
                DataCell(
                    Text(payment['amount'].toString(), // Convert int to String
                        style: const TextStyle(color: Colors.black))),
                DataCell(Text(payment['mobile_no'] ?? '',
                    style: const TextStyle(color: Colors.black))),
                DataCell(Text(formatDate(payment['date']),
                    style: const TextStyle(color: Colors.black))),
              ]);
            }).toList() ??
            [],
      ),
    ),
  );
}

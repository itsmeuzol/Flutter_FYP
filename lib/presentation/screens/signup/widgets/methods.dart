import 'dart:convert';

import 'package:finalyear/utils/urls.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void wardno(BuildContext context, TextEditingController _wardnoController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Ward No'),
        content: SizedBox(
          width: double.minPositive,
          height: 200,
          child: ListView.builder(
            itemCount: 32,
            itemBuilder: (BuildContext context, int index) {
              final wardNo = index + 1;
              return ListTile(
                title: Text('$wardNo'),
                onTap: () {
                  // Set the selected ward number to the text field's controller
                  _wardnoController.text = ' $wardNo';
                  // Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            },
          ),
        ),
      );
    },
  );
}

void houseno(BuildContext context, TextEditingController housenoController) {
  List<String> houseNumbers = ['111', '222', '333'];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select House No'),
        content: SizedBox(
          width: double.minPositive,
          height: 200,
          child: ListView.builder(
            itemCount: houseNumbers.length,
            itemBuilder: (BuildContext context, int index) {
              final houseNo = houseNumbers[index];
              return ListTile(
                title: Text(houseNo),
                onTap: () {
                  // Set the selected house number to the text field's controller
                  housenoController.text = houseNo;
                  // Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            },
          ),
        ),
      );
    },
  );
}

void location(BuildContext context, TextEditingController locationController) {
  List<String> locations = ['Maitidevi', 'Ghattekulo', 'Samakhusi'];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Locations:'),
        content: SizedBox(
          width: double.minPositive,
          height: 200,
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (BuildContext context, int index) {
              final location = locations[index];
              return ListTile(
                title: Text(location),
                onTap: () {
                  // Set the selected house number to the text field's controller
                  locationController.text = location;
                  // Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            },
          ),
        ),
      );
    },
  );
}

void selectAssignedStaff(
    BuildContext context, TextEditingController assignedStaff) async {
  List<dynamic> staffList =
      await fetchStaffData(); // Fetch staff data asynchronously

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Staff'),
        content: SizedBox(
          width: double.minPositive,
          height: 200,
          child: ListView.builder(
            itemCount: staffList.length,
            itemBuilder: (BuildContext context, int index) {
              final staff = staffList[index];
              return ListTile(
                title:
                    Text('${staff["name"]}'), // Display the staff member's name
                onTap: () {
                  // Set the selected staff member's name to the text field's controller
                  assignedStaff.text = staff["name"];
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            },
          ),
        ),
      );
    },
  );
}

Future<List<dynamic>> fetchStaffData() async {
  try {
    final response = await http.get(Uri.parse(baseUrl + getStaff));
    if (response.statusCode == 200) {
      final staffList = jsonDecode(response.body)['staffMembers'];
      return staffList;
    } else {
      print('Failed to fetch staff data: ${response.statusCode}');
      return []; // Return an empty list in case of failure
    }
  } catch (error) {
    print('Error fetching staff data: $error');
    return []; // Return an empty list in case of error
  }
}

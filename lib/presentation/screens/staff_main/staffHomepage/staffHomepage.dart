import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({super.key});

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Staff Home page"),
    );
  }
}

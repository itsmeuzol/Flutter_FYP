import 'package:flutter/material.dart';

class CustomBackIcon extends StatelessWidget {
  final Color color;
  final void Function()? onPressed;

  const CustomBackIcon(
      {super.key, this.color = Colors.white, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onPressed);
  }
}

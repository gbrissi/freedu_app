import 'package:flutter/material.dart';

class DrawerUserEmail extends StatelessWidget {
  const DrawerUserEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "placeholder@example.com",
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade200,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}
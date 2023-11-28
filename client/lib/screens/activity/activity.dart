import 'package:client/shared/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
      ),
    );
  }
}

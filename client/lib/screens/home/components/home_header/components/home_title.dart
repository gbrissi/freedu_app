import 'package:client/shared/components/page_title.dart';
import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageTitle(
      text: "Questões disponíveis",
    );
  }
}

import 'package:flutter/material.dart';

import 'components/home_post_create_button.dart';
import 'components/home_title.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: HomeTitle(),
        ),
        HomePostCreateButton(),
      ],
    );
  }
}

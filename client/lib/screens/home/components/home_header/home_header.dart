import 'package:client/shared/components/row_separated.dart';
import 'package:flutter/material.dart';

import 'components/home_post_create_button.dart';
import 'components/home_title.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return RowSeparated(
      spacing: 12,
      children:const  [
        Expanded(
          child: HomeTitle(),
        ),
        HomePostCreateButton(),
      ],
    );
  }
}

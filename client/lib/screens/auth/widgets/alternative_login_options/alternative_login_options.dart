import 'package:client/screens/auth/widgets/alternative_login_options/components/alternative_login_description.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:flutter/material.dart';

import 'components/alternative_login_options_row/alternative_login_options_row.dart';

class AlternativeLoginOptions extends StatelessWidget {
  const AlternativeLoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ColumnSeparated(
      spacing: 4,
      children: const [
        AlternativeLoginDescription(),
        AlternativeLoginOptionsRow(),
      ],
    );
  }
}
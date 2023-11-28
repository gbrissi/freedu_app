import 'package:flutter/material.dart';

import '../../../shared/components/custom_app_bar/custom_app_bar.dart';
import 'alternative_login_options/alternative_login_options.dart';
import 'app_logo.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.form,
    required this.linkToAnotherPage,
  });
  final Widget form;
  final Widget linkToAnotherPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 32,
                ),
                child: AppLogo(),
              ),
            ),
            Expanded(
              child: form,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: AlternativeLoginOptions(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: linkToAnotherPage,
            ),
          ],
        ),
      ),
    );
  }
}

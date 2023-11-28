import 'package:flutter/material.dart';

import '../../../shared/components/page_title.dart';
import 'auth_field/components/strength_bar/auth_field.dart';

class SubmitForm {
  final void Function() onTap;
  final String name;

  SubmitForm({
    required this.onTap,
    required this.name,
  });
}

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.title,
    required this.submit,
    required this.fields,
  });
  final List<AuthField> fields;
  final String title;
  final SubmitForm submit;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageTitle(
            text: title,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: fields,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
            ),
            child: SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Theme.of(context).buttonTheme.colorScheme!.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
                onPressed: submit.onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Text(
                    submit.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

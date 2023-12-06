import 'package:client/screens/auth/widgets/alternative_login_options/components/alternative_login_options_row/components/login_option.dart';
import 'package:client/shared/components/row_separated.dart';
import 'package:client/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlternativeLoginOptionsRow extends StatefulWidget {
  const AlternativeLoginOptionsRow({super.key});

  @override
  State<AlternativeLoginOptionsRow> createState() => _OptionsRowState();
}

class _OptionsRowState extends State<AlternativeLoginOptionsRow> {
  // Uri _getUri(html) => Uri.dataFromBytes(html, mimeType: 'text/html');

  // void _launchUrl(html) async {
  //   // final Uri url =
  //       // Uri.http(HttpClient.url, "auth/login/google"); // _getUri(html);
  //   // final result = await FlutterWebAuth.authenticate(
  //   //   url: url.toString(),
  //   //   callbackUrlScheme: "callback",
  //   // ); // final webview = await WebviewWindow.create();

  //   // webview.launch(url.toString());
  // }

  // void _redirectGoogle() {
  //   AuthRepository.googleLogin().then(
  //     (html) =>
  //         // context.pushNamed(
  //         //   "googleLogin",
  //         //   extra: _getUri(html),
  //         // ),
  //         _launchUrl(
  //       html,
  //     ),
  //   );
  // }

  // void _redirectFacebook() {
  //   // TODO:
  // }

  void _showUnimplemented() {
    showSnackbar(
      context,
      SnackBarResult.failure("Método não implementado"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RowSeparated(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginOption(
          icon: FontAwesomeIcons.google,
          onTap: _showUnimplemented,
        ),
        LoginOption(
          icon: FontAwesomeIcons.facebook,
          onTap: _showUnimplemented,
        ),
      ],
    );
  }
}

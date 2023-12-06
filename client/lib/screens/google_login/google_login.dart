import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../shared/http/models/http_client.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({
    super.key,
    required this.uri,
  });
  final Uri uri;

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  InAppWebViewController? webViewController;

  void onPageChange(_, value, __) {
    // print('valor: $value');
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: Uri.http(
          HttpClient.url,
          "/auth/login/google",
        ), // <-- your link
      ),
      onWebViewCreated: (controller) => webViewController = controller,
      onUpdateVisitedHistory: onPageChange,
    );
  }

  // late final WebViewController _controller = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..loadRequest(Uri.http(HttpClient.url, "/auth/login/google"));

  // @override
  // Widget build(BuildContext context) {
  //   return WebViewWidget(
  //     controller: _controller,
  //   );
  // }
}

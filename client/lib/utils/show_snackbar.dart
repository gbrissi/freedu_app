import 'package:client/shared/http/models/api_result.dart';
import 'package:flutter/material.dart';

Color get failureColor => Colors.red;
Color get successColor => Colors.green;

class SnackBarResult {
  final Color color;
  final String text;

  SnackBarResult.failure(this.text) : color = failureColor;
  SnackBarResult.success(this.text) : color = successColor;
  SnackBarResult.fromApiResult(ApiResult result)
      : color = result.isError ? failureColor : successColor,
        text = result.result.message;

  SnackBarResult({
    required this.color,
    required this.text,
  });
}

showSnackbar(BuildContext context, SnackBarResult result) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: result.color,
      content: Text(
        result.text,
      ),
    ),
  );
}

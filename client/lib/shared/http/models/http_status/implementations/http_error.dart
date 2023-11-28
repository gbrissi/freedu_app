import 'dart:convert';

import 'package:http/http.dart';

import '../http_status.dart';

Map<String, dynamic> _decodeResponse(Response response) {
  try {
    return jsonDecode(utf8.decode(response.bodyBytes));
  } catch (error) {
    return <String, dynamic>{
      "message": "Unhandled client error",
      "error": error.toString(),
    };
  }
}

class HttpError extends HttpStatus {
  final String error;

  HttpError({
    required super.message,
    required super.statusCode,
    required this.error,
  });

  HttpError.fromResponse(Response response)
      : error = _decodeResponse(response)['error'].toString(),
        super(
          message: _decodeResponse(response)['message'],
          statusCode: response.statusCode,
        );
}

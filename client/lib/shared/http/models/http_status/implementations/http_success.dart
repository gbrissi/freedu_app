import 'dart:convert';

import 'package:http/http.dart';

import '../http_status.dart';

Map<String, dynamic> _decodeResponse(Response response) =>
    jsonDecode(utf8.decode(response.bodyBytes));

class HttpSuccess<T> extends HttpStatus {
  final T data;

  HttpSuccess({
    required super.message,
    required super.statusCode,
    required this.data,
  });

  HttpSuccess.fromResponse(
    Response response,
    T Function(dynamic data) dataConstruct,
  )   : data = dataConstruct(
          _decodeResponse(response)['data'],
        ),
        super(
          message: _decodeResponse(response)['message'],
          statusCode: response.statusCode,
        );
}

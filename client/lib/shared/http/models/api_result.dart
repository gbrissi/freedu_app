import 'package:client/shared/extensions/response_ok.dart';
import 'package:client/shared/http/models/http_status/implementations/http_error.dart';
import 'package:http/http.dart';

import 'http_status/http_status.dart';
import 'http_status/implementations/http_success.dart';

HttpStatus _getHttpStatus<T>(
  Response response,
  T Function(dynamic data) constructor,
) =>
    response.ok
        ? HttpSuccess.fromResponse(response, constructor)
        : HttpError.fromResponse(response);

class ApiResult<T> {
  final HttpStatus result;
  final bool isError;

  ApiResult.fromResponse(
    Response response,
    T Function(dynamic data) constructor,
  )   : isError = !response.ok,
        result = _getHttpStatus<T>(
          response,
          constructor,
        );
}

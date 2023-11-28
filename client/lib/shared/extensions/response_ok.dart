import 'package:http/http.dart';

extension IsOk on Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

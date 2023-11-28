abstract class HttpStatus {
  final String message;
  final int statusCode;

  HttpStatus({
    required this.message,
    required this.statusCode,
  });
}

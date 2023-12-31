import 'dart:convert';

import 'package:client/services/shared_prefs_service.dart';
import 'package:client/shared/http/models/http_status/implementations/http_success.dart';
import 'package:client/shared/http/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'jwt_payload.dart';
import 'jwt_token.dart';

String? _nullableJsonEncode(Map<String, dynamic>? object) {
  String? json;
  if (object != null) {
    json = jsonEncode(object);
  }

  return json;
}

class HttpClient {
  final http.Client client = http.Client();
  static const String url = "freedu-app-server.onrender.com";
  // Platform.isAndroid ? "192.168.1.111:3000" : "localhost:3000";
  static final HttpClient instance = HttpClient();

  Map<String, String> _getHeaders(String? token) {
    final Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final Map<String, String> headers = token != null
        ? {
            ...defaultHeaders,
            ...{
              'Authorization': 'Bearer $token',
            },
          }
        : defaultHeaders;

    return headers;
  }

  Future<Map<String, String>> _getHttpHeaders({
    required bool sendAuthToken,
    String? customToken,
  }) async {
    late final String? token;

    if (customToken != null) {
      token = customToken;
    } else {
      token = sendAuthToken ? await _getAccessToken() : null;
    }

    return _getHeaders(token);
  }

  JwtPayload _getPayload(String token) {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return JwtPayload.fromJson(decodedToken);
  }

  Future<String?> _getAccessToken() async {
    String? accessToken;
    final JwtToken? jwtToken = await SharedPrefsService.getJwtToken();

    if (jwtToken != null) {
      final JwtPayload accessTokenPayload = _getPayload(jwtToken.accessToken);
      final JwtPayload refreshTokenPayload = _getPayload(jwtToken.refreshToken);

      if (accessTokenPayload.isExpired && refreshTokenPayload.isExpired) {
        // TODO: Redirect to login if refresh token is expired and wait for new JwtToken callback.
      } else if (accessTokenPayload.isExpired) {
        await AuthRepository.refreshAccessToken(
          refreshToken: jwtToken.refreshToken,
        ).then((value) async {
          if (!value.isError) {
            final newJwtToken = value.result as HttpSuccess<JwtToken>;
            accessToken = newJwtToken.data.accessToken;
            await SharedPrefsService.storeJwtToken(newJwtToken.data);
          }
        });
      } else {
        accessToken = jwtToken.accessToken;
      }
    }

    return accessToken;
  }

  Future<http.Response> _sendHttpReq(
    String path,
    bool sendAuthToken,
    Future<http.Response> Function(
      Uri uri,
      Map<String, String> headers,
    ) httpCallback, {
    String? customToken,
    Map<String, String?>? queryParams,
  }) async {
    final Uri uri = Uri.https(url, path, queryParams);
    final Map<String, String> headers = await _getHttpHeaders(
      sendAuthToken: sendAuthToken,
      customToken: customToken,
    );

    final http.Response response = await httpCallback(uri, headers);
    return response;
  }

  Future<http.Response> post({
    required String path,
    Map<String, String>? queryParams,
    Map<String, dynamic>? body,
    String? customToken,
    bool useAccessToken = false,
  }) =>
      _sendHttpReq(
        path,
        useAccessToken,
        customToken: customToken,
        queryParams: queryParams,
        (uri, headers) => client.post(
          uri,
          body: _nullableJsonEncode(body),
          headers: headers,
        ),
      );

  Future<http.Response> patch({
    required String path,
    required Map<String, String?> body,
    bool useAccessToken = false,
  }) =>
      _sendHttpReq(
        path,
        useAccessToken,
        (uri, headers) => client.patch(
          uri,
          body: _nullableJsonEncode(body),
          headers: headers,
        ),
      );

  Future<http.Response> delete({
    required String path,
    required Map<String, String> body,
    bool useAccessToken = false,
  }) =>
      _sendHttpReq(
        path,
        useAccessToken,
        (uri, headers) => client.delete(
          uri,
          body: _nullableJsonEncode(body),
          headers: headers,
        ),
      );

  Future<http.Response> get({
    required String path,
    Map<String, String?>? query,
    bool useAccessToken = false,
  }) =>
      _sendHttpReq(
        path,
        useAccessToken,
        queryParams: query,
        (uri, headers) => client.get(
          uri,
          headers: headers,
        ),
      );
}

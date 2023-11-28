import "package:client/shared/http/models/api_result.dart";
import "package:client/shared/http/models/jwt_token.dart";
import "package:http/http.dart";

import "../models/http_client.dart";

class AuthRepository {
  static Future<dynamic> googleLogin() async {
    final Response response = await HttpClient.instance.get(
      path: "/auth/login/google",
    );

    return response.bodyBytes;
  }

  static Future<ApiResult<JwtToken>> passwordLogin({
    required String username,
    required String password,
  }) async {
    return HttpClient.instance.post(
      path: "auth/login/password",
      // TODO: This is unwanted, but passport uses query to catch the username and password
      queryParams: {
        "username": username,
        "password": password,
      },
    ).then((response) {
      return ApiResult<JwtToken>.fromResponse(
        response,
        (data) => JwtToken.fromJson(data),
      );
    });
  }

  static Future<ApiResult<JwtToken>> registerAccount({
    required String name,
    required String username,
    required String password,
  }) async {
    return HttpClient.instance.post(
      path: "auth/register/password",
      body: {
        "name": name,
        "username": username,
        "password": password,
      },
    ).then((response) {
      return ApiResult<JwtToken>.fromResponse(
        response,
        (data) => JwtToken.fromJson(data),
      );
    });
  }

  static Future<ApiResult<JwtToken>> refreshAccessToken({
    required String refreshToken,
  }) async {
    return HttpClient.instance
        .post(
      path: "auth/login/refresh",
      customToken: refreshToken,
    )
        .then((response) {
      return ApiResult<JwtToken>.fromResponse(
        response,
        (data) => JwtToken.fromJson(data),
      );
    });
  }
}

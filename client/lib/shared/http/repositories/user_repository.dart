import 'dart:convert';

import 'package:client/shared/http/models/picker_image.dart';
import 'package:client/shared/http/models/user_profile_model.dart';

import '../models/api_result.dart';
import '../models/http_client.dart';

class UserRepository {
  static Future<ApiResult<UserProfileModel>> updateProfile({
    required String name,
    required String? description,
    required String? email,
    required PickerImage? picture,
  }) async {
    return HttpClient.instance.patch(
      path: "users/me",
      useAccessToken: true,
      body: {
        "email": email,
        "name": name,
        "description": description,
        "picture": picture != null ? jsonEncode(picture.toJson()) : null,
      },
    ).then((response) {
      return ApiResult<UserProfileModel>.fromResponse(
        response,
        (data) => UserProfileModel.fromJson(data),
      );
    });
  }

  static Future<ApiResult<UserProfileModel>> getProfile({
    required int userId,
  }) async {
    return HttpClient.instance.get(
      path: "users/id",
      useAccessToken: false,
      query: {
        "userId": userId.toString(),
      },
    ).then((response) {
      return ApiResult<UserProfileModel>.fromResponse(
        response,
        (data) => UserProfileModel.fromJson(data),
      );
    });
  }
}

import 'dart:convert';

import 'package:client/shared/http/models/answer_model.dart';
import 'package:client/shared/http/models/comment_model.dart';

import '../models/api_result.dart';
import '../models/http_client.dart';
import '../models/page_options.dart';

class AnswerRepository {
  static Future<ApiResult<List<CommentModel>>> getComments({
    required int answerId,
    required PageOptions pageOptions,
  }) async {
    return HttpClient.instance.get(
      path: "answers/id/comments",
      useAccessToken: false,
      query: {
        "answerId": answerId.toString(),
        "pageOptions": jsonEncode(
          pageOptions.toJson(),
        ),
      },
    ).then(
      (response) {
        return ApiResult<List<CommentModel>>.fromResponse(response, (data) {
          print("dados: $data");
          return (data as List<dynamic>)
              .map<CommentModel>((e) => CommentModel.fromJson(e))
              .toList();
        });
      },
    );
  }

  static Future<ApiResult<CommentModel>> sendComment({
    required String answer,
    required int answerId,
  }) async {
    return HttpClient.instance.post(
      path: "answers/id/comments",
      useAccessToken: true,
      body: {
        "answer": answer,
        "answerId": answerId,
      },
    ).then((response) {
      print("Resposta: ${response.body}");
      return ApiResult<CommentModel>.fromResponse(
        response,
        (data) => CommentModel.fromJson(data),
      );
    });
  }

  static Future<ApiResult<AnswerModel>> voteAnswer({
    required int target,
    required bool vote,
  }) async {
    return HttpClient.instance.post(
      path: "answers/id/votes",
      useAccessToken: true,
      body: {
        "answerId": target.toString(),
        "vote": vote,
      },
    ).then((response) {
      print("Resposta: ${response.body}");
      return ApiResult<AnswerModel>.fromResponse(
        response,
        (data) => AnswerModel.fromJson(data),
      );
    });
  }

  static Future<ApiResult<CommentModel>> voteAnswerComment({
    required int target,
    required bool vote,
  }) async {
    return HttpClient.instance.post(
      path: "answers/id/comments/id/votes",
      useAccessToken: true,
      body: {
        "commentId": target.toString(),
        "vote": vote,
      },
    ).then((response) {
      return ApiResult<CommentModel>.fromResponse(
        response,
        (data) => CommentModel.fromJson(data),
      );
    });
  }
}

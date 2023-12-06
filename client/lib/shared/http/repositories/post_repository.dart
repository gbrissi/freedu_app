import 'dart:convert';

import 'package:client/screens/create_post/providers/post_create_provider.dart';
import 'package:client/shared/http/models/answer_model.dart';
import 'package:client/shared/http/models/comment_model.dart';
import 'package:client/shared/http/models/post_card_model.dart';
import 'package:client/shared/http/models/post_view_model.dart';

import '../models/api_result.dart';
import '../models/http_client.dart';
import '../models/page_options.dart';

class PostRepository {
  static Future<ApiResult<List<PostCardModel>>> getCardsPaginated({
    required PageOptions pageOptions,
  }) async {
    return HttpClient.instance.get(
      path: "posts/cards/paginated",
      query: {
        "pageOptions": jsonEncode(
          pageOptions.toJson(),
        ),
      },
    ).then((response) {
      return ApiResult<List<PostCardModel>>.fromResponse(
        response,
        (data) => data.map<PostCardModel>((e) {
          return PostCardModel.fromJson(e);
        }).toList(),
      );
    });
  }

  static Future<ApiResult<CommentModel>> sendComment({
    required String answer,
    required int postId,
  }) async {
    return HttpClient.instance.post(
      path: "posts/id/comments",
      useAccessToken: true,
      body: {
        "answer": answer,
        "postId": postId,
      },
    ).then((response) {
      return ApiResult<CommentModel>.fromResponse(
        response,
        (data) => CommentModel.fromJson(data),
      );
    });
  }

  static Future<ApiResult<PostViewModel>> createPost(PostRegister post) async {
    return HttpClient.instance.post(
      path: "posts/",
      useAccessToken: true,
      body: {
        "content": post.content,
        "subject": post.subject,
        "tags": post.tags,
      },
    ).then((response) {
      return ApiResult<PostViewModel>.fromResponse(
        response,
        (data) => PostViewModel.fromJson(data),
      );
    });
  }

  static Future<ApiResult<AnswerModel>> sendAnswer({
    required String answer,
    required int postId,
  }) async {
    return HttpClient.instance.post(
      path: "posts/id/answers",
      useAccessToken: true,
      body: {
        "answer": answer,
        "postId": postId,
      },
    ).then((response) {
      print("RESPOSTA: ${response.body}");
      return ApiResult<AnswerModel>.fromResponse(
        response,
        (data) => AnswerModel.fromJson(data),
      );
    });
  }

  static Future<ApiResult<PostViewModel>> getPost(int postId) async {
    return HttpClient.instance.get(
      path: "posts/id",
      useAccessToken: false,
      query: {
        "postId": postId.toString(),
      },
    ).then((response) {
      return ApiResult<PostViewModel>.fromResponse(
        response,
        (data) => PostViewModel.fromJson(data),
      );
    });
  }

  static Future<ApiResult<PostViewModel>> votePost({
    required int target,
    required bool vote,
  }) async {
    return HttpClient.instance.post(
      path: "posts/id/votes",
      useAccessToken: true,
      body: {
        "postId": target.toString(),
        "vote": vote,
      },
    ).then((response) {
      return ApiResult<PostViewModel>.fromResponse(
        response,
        (data) => PostViewModel.fromJson(data),
      );
    });
  }

  static Future<ApiResult<CommentModel>> votePostComment({
    required int target,
    required bool vote,
  }) async {
    return HttpClient.instance.post(
      path: "posts/id/comments/id/votes",
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

  static Future<ApiResult<List<CommentModel>>> getComments({
    required int postId,
    required PageOptions pageOptions,
  }) async {
    return HttpClient.instance.get(
      path: "posts/id/comments",
      useAccessToken: false,
      query: {
        "postId": postId.toString(),
        "pageOptions": jsonEncode(
          pageOptions.toJson(),
        ),
      },
    ).then((response) {
      return ApiResult<List<CommentModel>>.fromResponse(
        response,
        (data) => (data as List<dynamic>)
            .map<CommentModel>((e) => CommentModel.fromJson(e))
            .toList(),
      );
    });
  }

  static Future<ApiResult<List<AnswerModel>>> getAnswers({
    required int postId,
    required PageOptions pageOptions,
  }) async {
    return HttpClient.instance.get(
      path: "posts/id/answers",
      useAccessToken: false,
      query: {
        "postId": postId.toString(),
        "pageOptions": jsonEncode(
          pageOptions.toJson(),
        ),
      },
    ).then((response) {
      return ApiResult<List<AnswerModel>>.fromResponse(
        response,
        (data) => (data as List<dynamic>)
            .map<AnswerModel>((e) => AnswerModel.fromJson(e))
            .toList(),
      );
    });
  }
}

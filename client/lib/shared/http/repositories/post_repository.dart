import 'dart:convert';

import 'package:client/screens/create_post/providers/post_create_provider.dart';
import 'package:client/shared/http/models/post_card_model.dart';

import '../models/api_result.dart';
import '../models/http_client.dart';
import '../models/page_options.dart';

class PostRepository {
  static Future<ApiResult<List<PostCardModel>>> getCardsPaginated({
    required PageOptions pageOptions,
  }) async {
    print("pageOptions: ${jsonEncode(
      pageOptions.toJson(),
    )}");
    return HttpClient.instance.get(
      path: "posts/cards/paginated",
      query: {
        "pageOptions": jsonEncode(
          pageOptions.toJson(),
        ),
      },
    ).then((response) {
      print("resposta: ${response.body}");
      return ApiResult<List<PostCardModel>>.fromResponse(
        response,
        (data) => data.map<PostCardModel>((e) {
          print("aqui o objeto: $e");
          return PostCardModel.fromJson(e);
        }).toList(),
      );
    });
  }

  static Future<ApiResult<List<PostCardModel>>> createPost(PostRegister post) async {
    return HttpClient.instance.post(
      path: "posts/",
      body: {
        "content": post.content,
        "subject": post.subject,
        "tags": post.tags,
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
}

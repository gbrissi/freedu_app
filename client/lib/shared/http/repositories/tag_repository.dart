import '../models/api_result.dart';
import '../models/http_client.dart';
import '../models/tag_model.dart';

class TagRepository {
  static Future<ApiResult<List<TagModel>>> getAvailableTags() async {
    return HttpClient.instance
        .get(path: "tags/")
        .then((response) {
      print("Resposta: ${response.body}");
      return ApiResult<List<TagModel>>.fromResponse(
        response,
        (data) => data.map<TagModel>((e) {
          return TagModel.fromJson(e);
        }).toList(),
      );
    });
  }
}

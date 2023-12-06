import 'package:client/shared/http/models/vote_model.dart';

import 'author_model.dart';

class AnswerModel {
  final int id;
  final String content;
  final List<VoteModel>? votes;
  final AuthorModel author;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['author'] = author.toJson();
    json['content'] = content;
    json['commentsCount'] = commentsCount;
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();
    json['votes'] = votes?.map((e) => e.toJson());

    return json;
  }

  AnswerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        votes = json['votes']
            ?.map<VoteModel>((e) => VoteModel.fromJson(e))
            .toList(),
        commentsCount = json['commentsCount'],
        author = AuthorModel.fromJson(json['author']),
        content = json['content'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}

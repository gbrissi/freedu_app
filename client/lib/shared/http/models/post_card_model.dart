import 'package:client/shared/http/models/tag_model.dart';

import 'author_model.dart';

class PostCardModel {
  final int id;
  final AuthorModel author;
  final String subject;
  final String content;
  final bool published;
  final int votes;
  final int answers;
  final List<TagModel> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['author'] = author.toJson();
    json['subject'] = subject;
    json['content'] = content;
    json['published'] = published;
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();
    json['votes'] = votes;
    json['answers'] = answers;
    json['tags'] = tags.map((e) => e.toJson()).toList();

    return json;
  }

  PostCardModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = AuthorModel.fromJson(json['author']),
        subject = json['subject'],
        tags = json['tags'].map<TagModel>((e) => TagModel.fromJson(e)).toList(),
        content = json['content'],
        votes = json['votes'],
        answers = json['votes'],
        published = json['published'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
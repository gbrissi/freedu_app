import 'author_model.dart';

class AnswerModel {
  final int id;
  final String content;
  final AuthorModel author;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['author'] = author.toJson();
    json['content'] = content;
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();

    return json;
  }

  AnswerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = AuthorModel.fromJson(json['author']),
        content = json['content'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}

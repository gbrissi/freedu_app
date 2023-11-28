import 'author_model.dart';

class CommentModel {
  final int id;
  final AuthorModel author;
  final String content;
  final int votes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['author'] = author.toJson();
    json['content'] = content;
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();
    json['votes'] = votes;

    return json;
  }

  CommentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = AuthorModel.fromJson(json['author']),
        content = json['content'],
        votes = json['votes'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}

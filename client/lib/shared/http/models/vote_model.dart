import 'author_model.dart';

class VoteModel {
  final int id;
  final int value;
  final AuthorModel author;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['author'] = author.toJson();
    json['value'] = value;
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();

    return json;
  }

  VoteModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = AuthorModel.fromJson(json['author']),
        value = json['value'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}

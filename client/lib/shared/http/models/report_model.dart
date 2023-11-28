// ignore_for_file: constant_identifier_names
import 'author_model.dart';

enum Option {
  MISINFORMATION,
  VIOLENT_CONTENT,
  INAPPROPRIATE_NAME,
  OTHER,
}

class ReportModel {
  final int id;
  final AuthorModel author;
  final Option option;
  final String reason;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['author'] = author.toJson();
    json['option'] = option;
    json['reason'] = reason;
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();


    return json;
  }

  ReportModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = AuthorModel.fromJson(json['author']),
        option = json['option'],
        reason = json['reason'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
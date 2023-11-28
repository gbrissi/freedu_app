import 'package:client/shared/http/models/report_model.dart';
import 'package:client/shared/http/models/tag_model.dart';
import 'package:client/shared/http/models/vote_model.dart';

import 'answer_model.dart';
import 'author_model.dart';

class PostModel {
  final int id;
  final AuthorModel author;
  final String subject;
  final String content;
  final bool published;
  final List<VoteModel> votes;
  final List<AnswerModel> answers;
  final List<ReportModel> reports;
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
    json['reports'] = reports;
    json['tags'] = tags.map((e) => e.toJson()).toList();

    return json;
  }

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = AuthorModel.fromJson(json['author']),
        subject = json['subject'],
        tags = json['tags'].map<TagModel>((e) => TagModel.fromJson(e)).toList(),
        content = json['content'],
        votes = json['votes'].map<VoteModel>((e) => VoteModel.fromJson(e)).toList(),
        answers = json['votes'],
        reports = json['reports'].map<ReportModel>((e) => ReportModel.fromJson(e)).toList(),
        published = json['published'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
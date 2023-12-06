import 'package:client/shared/http/models/tag_model.dart';
import 'package:client/shared/http/models/vote_model.dart';
import 'author_model.dart';

class PostViewModel {
  final int id;
  final AuthorModel author;
  final String subject;
  final String content;
  final List<VoteModel> votes;
  final int messagesCount;
  final List<TagModel> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['author'] = author.toJson();
    json['subject'] = subject;
    json['messagesCount'] = messagesCount;
    json['content'] = content;
    json['createdAt'] = createdAt.toIso8601String();
    json['updatedAt'] = updatedAt.toIso8601String();
    json['votes'] = votes;
    json['tags'] = tags.map((e) => e.toJson()).toList();

    return json;
  }

  PostViewModel.fromJson(Map<String, dynamic> json)
      : messagesCount = json['messagesCount'],
        id = json['id'],
        author = AuthorModel.fromJson(json['author']),
        subject = json['subject'],
        tags = json['tags'].map<TagModel>((e) => TagModel.fromJson(e)).toList(),
        content = json['content'],
        votes =
            json['votes'].map<VoteModel>((e) => VoteModel.fromJson(e)).toList(),
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}

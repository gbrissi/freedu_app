import 'package:client/screens/post/models/post_author_model.dart';

class PostViewModel {
  final String id;
  final PostAuthorModel author;
  final List<String> tags;
  final int views;
  final List<String> answersIdList;
  final int votes;
  final String title;
  final DateTime createdAt;
  final String description;

  PostViewModel({
    required this.id,
    required this.author,
    required this.tags,
    required this.createdAt,
    required this.views,
    required this.answersIdList,
    required this.votes,
    required this.title,
    required this.description,
  });
}

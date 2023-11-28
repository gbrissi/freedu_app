import 'home_author_model.dart';

class HomePostModel {
  final String id;
  final HomeAuthorModel author;
  final List<String> tags;
  final int views;
  final int answersCount;
  final int votes;
  final String title;
  final DateTime createdAt;
  final String description;

  HomePostModel({
    required this.id,
    required this.author,
    required this.tags,
    required this.createdAt,
    required this.views,
    required this.answersCount,
    required this.votes,
    required this.title,
    required this.description,
  });
}

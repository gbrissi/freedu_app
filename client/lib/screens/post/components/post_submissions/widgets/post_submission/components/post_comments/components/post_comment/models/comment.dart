class Comment {
  final String author;
  final int votes;
  final String message;
  final DateTime createdAt;

  Comment({
    required this.author,
    required this.votes,
    required this.message,
    required this.createdAt,
  });
}
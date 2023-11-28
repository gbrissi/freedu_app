import 'package:flutter/material.dart';

class PostRegister {
  final List<String>? tags;
  final String content;
  final String subject;

  PostRegister({
    required this.tags,
    required this.content,
    required this.subject,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['content'] = tags;
    json['subject'] = subject;
    json['tags'] = tags;

    return json;
  }
}

class PostCreateProvider extends ChangeNotifier {
  bool isSyncing = false;
  List<String>? tags;

  final void Function(PostRegister post) onSubmit;
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  String get subject => subjectController.text;
  String get content => contentController.text;

  PostCreateProvider({
    required this.onSubmit,
  });

  void submit() => onSubmit(
        PostRegister(
          tags: tags,
          content: content,
          subject: subject,
        ),
      );

  void setTags(List<String> value) {
    tags = value;
    notifyListeners();
  }

  void removeTag(String tag) {
    tags = tags?.where((e) => e != tag).toList();
    notifyListeners();
  }
}

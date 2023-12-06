import 'dart:async';

import 'package:client/screens/home/components/post_search/models/date_range.dart';
import 'package:flutter/material.dart';

class PostsFilterProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  String? _tempQuery;
  String? _query;
  String get query => _query ?? "";

  DateRange _dateRange = DateRange.empty();
  DateRange get dateRange => _dateRange;

  List<String> _tags = [];
  List<String> get tags => _tags;

  void addTag(String tag) {
    _tags = [...tags, tag];
    notifyListeners();
  }

  void removeTag(String tag) {
    _tags = _tags.where((e) => e != tag).toList();
    notifyListeners();
  }

  void setTags(List<String> tags) {
    _tags = tags;
    notifyListeners();
  }

  void setDateRange(DateRange range) {
    _dateRange = range;
    notifyListeners();
  }

  PostsFilterProvider() {
    searchController.addListener(() {
      _tempQuery = searchController.text;
      final String? reqSearch = _tempQuery;

      Future.delayed(const Duration(milliseconds: 500), () {
        if (reqSearch == _tempQuery) {
          _query = searchController.text;
          notifyListeners();
        }
      });
    });
  }
}

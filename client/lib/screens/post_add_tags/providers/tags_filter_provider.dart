import 'package:client/shared/http/models/api_result.dart';
import 'package:client/shared/http/models/http_status/implementations/http_success.dart';
import 'package:client/shared/http/models/tag_model.dart';
import 'package:client/shared/http/repositories/tag_repository.dart';
import 'package:flutter/material.dart';

class TagsFilterProvider extends ChangeNotifier {
  final ValueNotifier<List<String>> _tags;
  List<String> get tags => _tags.value;
  List<String>? unselectedTags;

  TagsFilterProvider({
    required ValueNotifier<List<String>> selectedTags,
  }) : _tags = selectedTags {
    TagRepository.getAvailableTags().then((
      ApiResult<List<TagModel>> apiResult,
    ) {
      if (!apiResult.isError) {
        final result = apiResult.result as HttpSuccess<List<TagModel>>;
        unselectedTags = result.data
            .where((e) => !tags.contains(e.name))
            .map((e) => e.name)
            .toList();

        notifyListeners();
      }
    });
  }

  void _replaceElementBetweenLists(
    int elementIndex,
    List<String> from,
    List<String> to,
  ) {
    final String selectedElement = from[elementIndex];
    to.add(selectedElement);
    from.removeAt(elementIndex);
  }

  void removeSelectedTag(int index) {
    _replaceElementBetweenLists(
      index,
      _tags.value,
      unselectedTags!,
    );

    notifyListeners();
  }

  void selectTag(int index) {
    _replaceElementBetweenLists(
      index,
      unselectedTags!,
      _tags.value,
    );

    notifyListeners();
  }
}

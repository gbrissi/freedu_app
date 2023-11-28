import 'package:client/screens/post_add_tags/components/post_tags_builder.dart';
import 'package:client/shared/components/removable_tag.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tags_filter_provider.dart';

class SelectedTags extends StatefulWidget {
  const SelectedTags({super.key});

  @override
  State<SelectedTags> createState() => _SelectedTagsState();
}

class _SelectedTagsState extends State<SelectedTags> {
  late final controller = context.read<TagsFilterProvider>();

  int get tagsCount => controller.tags.length;
  late int curCount;

  @override
  void initState() {
    curCount = tagsCount;
    controller.addListener(() {
      if (curCount != tagsCount && mounted) {
        setState(() {
          curCount = tagsCount;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PostTagsBuilder(
      description: "Marcadores selecionados",
      children: controller.tags
          .mapIndexed(
            (index, tag) => RemovableTag(
              onTap: () => controller.removeSelectedTag(
                index,
              ),
              text: tag,
            ),
          )
          .toList(),
    );
  }
}

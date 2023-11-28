import 'package:client/screens/post_add_tags/components/post_tags_builder.dart';
import 'package:client/screens/post_add_tags/providers/tags_filter_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/components/tag.dart';

class TagsSelectList extends StatefulWidget {
  const TagsSelectList({super.key});

  @override
  State<TagsSelectList> createState() => _TagsSelectListState();
}

class _TagsSelectListState extends State<TagsSelectList> {
  late final controller = context.read<TagsFilterProvider>();

  int get tagsCount => controller.unselectedTags?.length ?? 0;
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
      description: "Marcadores não selecionados",
      children: controller.unselectedTags
              ?.mapIndexed<Widget>(
                (index, tag) => Tag(
                  onTap: () => controller.selectTag(
                    index,
                  ),
                  text: tag,
                ),
              )
              .toList() ??
          [],
    );
  }
}

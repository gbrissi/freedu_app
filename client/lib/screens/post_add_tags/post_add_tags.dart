import 'package:client/screens/post_add_tags/providers/tags_filter_provider.dart';
import 'package:client/shared/components/custom_app_bar/components/leading_builder.dart';
import 'package:client/shared/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../shared/components/column_separated.dart';
import 'components/post_add_tags_title.dart';
import 'components/selected_tags.dart';
import 'components/tags_select_list.dart';

class PostAddTags extends StatefulWidget {
  const PostAddTags({
    super.key,
    required this.value,
  });
  final List<String> value;

  @override
  State<PostAddTags> createState() => _PostAddTagsState();
}

class _PostAddTagsState extends State<PostAddTags> {
  late final ValueNotifier<List<String>> _tags = ValueNotifier(widget.value);
  List<String> get tags => _tags.value;
  void _getTooltips() => context.pop(tags);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TagsFilterProvider(
        selectedTags: _tags,
      ),
      child: Scaffold(
        appBar: CustomAppBar.custom(
          leading: LeadingBuilder(
            tooltip: "Retornar marcadores",
            onTap: _getTooltips,
            icon: Icons.arrow_back,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ColumnSeparated(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              PostAddTagsTitle(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectedTags(),
                  TagsSelectList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

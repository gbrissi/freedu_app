import 'package:client/screens/home/provider/posts_filter_provider.dart';
import 'package:client/shared/components/pop_up_menu_item_description.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/components/action_dropdown_button.dart';
import '../models/date_range.dart';

class PostFilterButton extends StatefulWidget {
  const PostFilterButton({super.key});

  @override
  State<PostFilterButton> createState() => _PostFilterButtonState();
}

class _PostFilterButtonState extends State<PostFilterButton> {
  late final _filterController = context.read<PostsFilterProvider>();

  void _getDateRangeFilter() async {
    final DateRange? range = await context.pushNamed(
      "dateFilter",
      extra: _filterController.dateRange,
    );

    if (range != null) {
      _filterController.setDateRange(
        range,
      );
    }
  }

  void _getTagsFilter() async {
    final List<String>? tags = await context.pushNamed(
      "filterTags",
      extra: _filterController.tags,
    );

    if (tags != null) {
      _filterController.setTags(tags);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionDropdownButton(
      label: "Filtrar",
      icon: Icons.sort,
      items: [
        PopupMenuItem(
          onTap: _getDateRangeFilter,
          child: const PopUpMenuItemDescription(
            text: "Filtrar data",
            icon: Icons.date_range,
          ),
        ),
        PopupMenuItem(
          onTap: _getTagsFilter,
          child: const PopUpMenuItemDescription(
            text: "Selecionar marcadores",
            icon: Icons.sell,
          ),
        ),
      ],
    );
  }
}

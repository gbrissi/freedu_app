import 'package:client/screens/home/provider/posts_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostSearchBar extends StatefulWidget {
  const PostSearchBar({super.key});

  @override
  State<PostSearchBar> createState() => _PostSearchBarState();
}

class _PostSearchBarState extends State<PostSearchBar> {
  late final _filterController = context.read<PostsFilterProvider>();
  late final _searchController = _filterController.searchController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: "Procurar publicação.",
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(99),
          ),
        ),
        prefixIcon: Icon(
          Icons.search,
        ),
      ),
    );
  }
}

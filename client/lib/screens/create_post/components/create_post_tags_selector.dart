import 'package:client/screens/create_post/providers/post_create_provider.dart';
import 'package:client/shared/components/removable_tag.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreatePostTagsSelector extends StatefulWidget {
  const CreatePostTagsSelector({super.key});

  @override
  State<CreatePostTagsSelector> createState() => _CreatePostTagsSelectorState();
}

class _CreatePostTagsSelectorState extends State<CreatePostTagsSelector> {
  late final controller = context.read<PostCreateProvider>();

  int get tagsCount => controller.tags?.length ?? 0;
  late int curCount;

  void _selectTags() async {
    final List<String>? tags = await context.pushNamed(
      'addTags',
      extra: controller.tags,
    );

    if (tags != null) {
      controller.setTags(tags);
    }
  }

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

  List<Widget> get postTags => !(controller.tags?.isEmpty ?? true)
      ? [...controller.tags ?? []]
          .map(
            (tag) => RemovableTag(
              text: tag,
              onTap: () => controller.removeTag(
                tag,
              ),
            ),
          )
          .toList()
      : [
          const SizedBox(
            width: 140,
            child: Text(
              "Nenhum marcador selecionado",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: [
        ...postTags,
        IconButton(
          onPressed: _selectTags,
          icon: const Icon(
            Icons.add,
          ),
        )
      ],
    );
  }
}

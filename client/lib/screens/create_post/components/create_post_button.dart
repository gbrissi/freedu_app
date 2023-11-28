import 'package:client/screens/create_post/providers/post_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreatePostButton extends StatefulWidget {
  const CreatePostButton({super.key});

  @override
  State<CreatePostButton> createState() => _CreatePostButtonState();
}

class _CreatePostButtonState extends State<CreatePostButton> {
  late final controller = context.read<PostCreateProvider>();
  bool get isSyncing => controller.isSyncing;

  void Function()? get submit => isSyncing ? controller.submit : null;
  void Function()? get callback => !isSyncing ? showConfirmDialog : null;

  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Você deseja submeter a sua publicação?"),
          actions: [
            TextButton(
              onPressed: context.pop,
              child: const Text("Não"),
            ),
            TextButton(
              onPressed: () {
                if (submit != null) {
                  submit!();
                }

                // TODO: Await for result and decide whether to stay on the page
                // or be redirected to the publication.
                // context.pop();
              },
              child: const Text("Sim"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: callback,
      child: const Icon(
        Icons.done,
      ),
    );
  }
}

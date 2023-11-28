import 'package:client/shared/components/custom_app_bar/components/leading_builder.dart';
import 'package:client/shared/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreatePostAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CreatePostAppBar({super.key});

  @override
  State<CreatePostAppBar> createState() => _CreatePostAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(
        kMinInteractiveDimension,
      );
}

class _CreatePostAppBarState extends State<CreatePostAppBar> {
  void confirmCallback() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Desejas descartar a sua publicação?"),
          actions: [
            TextButton(
              onPressed: context.pop,
              child: const Text("Não"),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                context.pop();
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
    return CustomAppBar.custom(
      leading: LeadingBuilder(
        tooltip: "Voltar a página anterior",
        onTap: confirmCallback,
        icon: Icons.arrow_back,
      ),
    );
  }
}

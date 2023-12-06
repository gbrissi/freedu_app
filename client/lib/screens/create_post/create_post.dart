import 'package:client/screens/create_post/components/create_post_description.dart';
import 'package:client/screens/create_post/providers/post_create_provider.dart';
import 'package:client/shared/components/column_separated.dart';
import 'package:client/shared/http/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../shared/http/models/api_result.dart';
import '../../shared/http/models/post_view_model.dart';
import '../../utils/show_snackbar.dart';
import 'components/create_post_app_bar.dart';
import 'components/create_post_button.dart';
import 'components/create_post_content.dart';
import 'components/create_post_subject.dart';
import 'components/create_post_tags_selector.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  void _onSubmit(PostRegister post) {
    PostRepository.createPost(post).then((ApiResult<PostViewModel> post) {
      if (mounted) {
        showSnackbar(
          context,
          SnackBarResult.fromApiResult(post),
        );

        if (!post.isError) {
          final int postId = post.get().id;
          context.pop();
          context.pushNamed(
            "post",
            extra: postId,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostCreateProvider(
        onSubmit: _onSubmit,
      ),
      child: Scaffold(
        appBar: const CreatePostAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ColumnSeparated(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: const [
              CreatePostDescription(),
              CreatePostSubject(),
              CreatePostContent(),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: CreatePostTagsSelector(),
              ),
            ],
          ),
        ),
        floatingActionButton: const CreatePostButton(),
      ),
    );
  }
}

import 'package:client/screens/home/components/post_card_list/components/post_card/components/post_card_meta/models/post_meta_data_model.dart';
import 'package:client/screens/home/components/post_card_list/components/post_card/provider/post_card_provider.dart';
import 'package:client/shared/components/row_separated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/post_meta_data.dart';

class PostCardMeta extends StatefulWidget {
  const PostCardMeta({super.key});

  @override
  State<PostCardMeta> createState() => _PostCardMetaState();
}

class _PostCardMetaState extends State<PostCardMeta> {
  late final controller = context.read<PostCardProvider>();
  // TODO:
  // int get postViewCount => controller.post.views;
  int get postVotesCount => controller.post.votes;
  int get postAnswersCount => controller.post.answers;

  @override
  Widget build(BuildContext context) {
    print(postAnswersCount);
    return RowSeparated(
      spacing: 6,
      children: [
        // PostMetaData(
        //   metadata: PostMetaDataModel(
        //     count: 0,
        //     label: "Visualizações",
        //   ),
        // ),
        // Container(
        //   height: 12,
        //   width: 1,
        //   color: Theme.of(context).textTheme.bodyMedium!.color,
        // ),
        PostMetaData(
          metadata: PostMetaDataModel(
            count: postAnswersCount,
            label: "Respostas",
          ),
        ),
        Container(
          height: 12,
          width: 1,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
        PostMetaData(
          metadata: PostMetaDataModel(
            count: postVotesCount,
            label: "Votos",
          ),
        ),
      ],
    );
  }
}

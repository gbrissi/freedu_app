import type { Post } from "@prisma/client";
import { Request } from "express";
import PostRepository from "../repositories/PostRepository";
import { PageOptions } from "../interfaces/PageOptions";
import { PostCardModel } from "../interfaces/PageCardModel";

const postRepo = new PostRepository();

export default class PostService {
  createPost(req: Request): Promise<Post> {
    const subject: string = req.body.subject;
    const content: string = req.body.content;
    const tags = req.body.tags;

    return new Promise((resolve, reject) => {
      postRepo
        .createPost({
          authorId: 1,
          description: content,
          subject,
          tags,
        })
        .then((post: Post) => resolve(post))
        .catch((err) => reject(err));
    });
  }

  getPaginatedPostsCards(req: Request): Promise<PostCardModel[]> {
    console.log("pageOptions: ", req.query.pageOptions);
    const pageOptions: PageOptions = JSON.parse(
      req.query.pageOptions as string
    );

    return new Promise((resolve, reject) => {
      postRepo
        .getPaginatedPosts(pageOptions)
        .then((posts: PostCardModel[]) => resolve(posts))
        .catch((err) => reject(err));
    });
  }
}

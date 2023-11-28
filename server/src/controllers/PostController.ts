import type { Post } from "@prisma/client";
import { Request, Response } from "express";
import PostService from "../services/PostService";
import { PostCardModel } from "../interfaces/PageCardModel";

const postService = new PostService();

export default class PostController {
  createPost(req: Request, res: Response) {
    postService
      .createPost(req)
      .then((post: Post) =>
        res
          .status(200)
          .send({ message: "Successfully created post", data: post })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  getPaginatedPosts(req: Request, res: Response) {
    postService
      .getPaginatedPostsCards(req)
      .then((posts: PostCardModel[]) =>
        res
          .status(200)
          .send({ message: "Successfully received posts data", data: posts })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }
}

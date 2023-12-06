import type { Answer, Post } from "@prisma/client";
import { Request, Response } from "express";
import PostService from "../services/PostService";
import { PostCardModel } from "../interfaces/PageCardModel";
import { PostViewModel } from "../interfaces/PostViewModel";
import { AnswerModel } from "../interfaces/AnswerModel";
import { CommentModel } from "../interfaces/CommentModel";

const postService = new PostService();

export default class PostController {
  createPost(req: Request, res: Response) {
    postService
      .createPost(req)
      .then((post: PostViewModel) =>
        res
          .status(200)
          .send({ message: "Successfully created post", data: post })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  sendAnswer(req: Request, res: Response) {
    postService
      .sendAnswer(req)
      .then((answer: AnswerModel) =>
        res
          .status(200)
          .send({ message: "Successfully created answer", data: answer })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  sendPostComment(req: Request, res: Response) {
    postService
      .sendComment(req)
      .then((comment: CommentModel) =>
        res
          .status(200)
          .send({ message: "Successfully created comment", data: comment })
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

  getPostComments(req: Request, res: Response) {
    postService
      .getPostComments(req)
      .then((comments: CommentModel[]) =>
        res.status(200).send({
          message: "Successfully received comments data",
          data: comments,
        })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  getPostView(req: Request, res: Response) {
    postService
      .getPost(req)
      .then((post: PostViewModel) =>
        res
          .status(200)
          .send({ message: "Successfully received post data", data: post })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  getAnswers(req: Request, res: Response) {
    postService
      .getAnswers(req)
      .then((answers: AnswerModel[]) =>
        res.status(200).send({
          message: "Successfully received answers data",
          data: answers,
        })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  votePostComment(req: Request, res: Response) {
    postService
      .voteComment(req)
      .then((comment: CommentModel) =>
        res
          .status(200)
          .send({ message: "Successfully voted comment", data: comment })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  votePost(req: Request, res: Response) {
    postService
      .votePost(req)
      .then((answer: PostViewModel) =>
        res
          .status(200)
          .send({ message: "Successfully voted answer", data: answer })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }
}

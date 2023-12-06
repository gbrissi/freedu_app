import type { Answer, Post } from "@prisma/client";
import { Request } from "express";
import PostRepository from "../repositories/PostRepository";
import { PageOptions } from "../interfaces/PageOptions";
import { PostCardModel } from "../interfaces/PageCardModel";
import { PostViewModel } from "../interfaces/PostViewModel";
import { JwtReduced } from "../models/JwtToken";
import { AnswerModel } from "../interfaces/AnswerModel";
import { CommentModel } from "../interfaces/CommentModel";

const postRepo = new PostRepository();

export default class PostService {
  createPost(req: Request): Promise<PostViewModel> {
    const subject: string = req.body.subject;
    const content: string = req.body.content;
    const tags: string[] = req.body.tags;
    console.log("Conteúdo: ", content);

    return new Promise((resolve, reject) => {
      postRepo
        .createPost({
          authorId: 1,
          description: content,
          subject,
          tags,
        })
        .then((post: PostViewModel) => resolve(post))
        .catch((err) => reject(err));
    });
  }

  getPostComments(req: Request): Promise<CommentModel[]> {
    const postId: number = parseInt(req.query.postId as string);
    const pageOptions: PageOptions = JSON.parse(
      req.query.pageOptions as string
    );

    return new Promise((resolve, reject) => {
      postRepo
        .getPostComments(postId, pageOptions)
        .then((value) => resolve(value))
        .catch((err) => reject(err));
    });
  }

  getAnswers(req: Request): Promise<AnswerModel[]> {
    const postId: number = parseInt(req.query.postId as string);
    const pageOptions: PageOptions = JSON.parse(
      req.query.pageOptions as string
    );

    return new Promise((resolve, reject) => {
      postRepo
        .getAnswers(postId, pageOptions)
        .then((value) => resolve(value))
        .catch((err) => reject(err));
    });
  }

  sendAnswer(req: Request): Promise<AnswerModel> {
    const postId: number = parseInt(req.body.postId as string);
    const answer: string = req.body.answer as string;
    const userId: number = (req.user as JwtReduced).id;

    return new Promise((resolve, reject) => {
      postRepo
        .createAnswer(postId, userId!, answer)
        .then((result) => resolve(result))
        .catch((err) => reject(err));
    });
  }

  sendComment(req: Request): Promise<CommentModel> {
    const postId: number = parseInt(req.body.postId as string);
    const answer: string = req.body.answer as string;
    const userId: number = (req.user as JwtReduced).id;

    return new Promise((resolve, reject) => {
      postRepo
        .createPostComment(postId, userId!, answer)
        .then((result) => resolve(result))
        .catch((err) => reject(err));
    });
  }

  getPost(req: Request): Promise<PostViewModel> {
    const postId: number = parseInt(req.query.postId as string);

    return new Promise((resolve, reject) => {
      postRepo
        .getPostView(postId)
        .then((value) => resolve(value))
        .catch((error) => reject(error));
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

  votePost(req: Request): Promise<PostViewModel> {
    const postId: number = parseInt(req.body.postId as string);
    const vote: boolean = req.body.vote as boolean;
    const userId: number = (req.user as JwtReduced).id;

    return new Promise((resolve, reject) => {
      postRepo
        .votePost(postId, vote ? 1 : -1, userId!)
        .then((result) => resolve(result))
        .catch((err) => reject(err));
    });
  }

  voteComment(req: Request): Promise<CommentModel> {
    const commentId: number = parseInt(req.body.commentId as string);
    const vote: boolean = req.body.vote as boolean;
    const userId: number = (req.user as JwtReduced).id;

    return new Promise((resolve, reject) => {
      postRepo
        .votePostComment(commentId, vote ? 1 : -1, userId!)
        .then((result) => resolve(result))
        .catch((err) => reject(err));
    });
  }
}

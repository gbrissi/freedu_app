import prisma from "../config/prismaClient";
import type { Post, PostVote } from "@prisma/client";
import { PageOptions } from "../interfaces/PageOptions";
import { PostCardModel } from "../interfaces/PageCardModel";
import {
  PostViewModel,
  _transformPostView,
  postViewModelQuery,
} from "../interfaces/PostViewModel";
import { CommentModel, _transformCommentModel, commentModelQuery } from "../interfaces/CommentModel";
import {
  AnswerModel,
  answerModelPrismaQuery,
  convertQueryToAnswerModel,
} from "../interfaces/AnswerModel";
import { voteModelQuery } from "../interfaces/VoteModel";

function _countVotes(votes: PostVote[]): number {
  let count: number = 0;
  for (let vote of votes) {
    count += vote.value;
  }

  return count;
}

export default class PostRepository {
  createPost({
    authorId,
    subject,
    description,
    tags,
  }: {
    authorId: number;
    subject: string;
    description: string;
    tags: string[];
  }): Promise<PostViewModel> {
    return new Promise((resolve, reject) => {
      prisma.post
        .create({
          data: {
            subject: subject,
            content: description,
            authorId: authorId,

            tags: {
              // TODO: Need to test it yet.
              connect: tags.map((tag) => ({ name: tag })),
            },
          },
          select: postViewModelQuery,
        })
        .then((post) => {
          if (!post) return reject("Post creation error");
          else return resolve(_transformPostView(post));
        })
        .catch((err) => reject(err));
    });
  }

  createAnswer(
    postId: number,
    authorId: number,
    answer: string
  ): Promise<AnswerModel> {
    return new Promise((resolve, reject) => {
      prisma.answer
        .create({
          data: {
            content: answer,
            author: { connect: { id: authorId } }, // Connect to the user who authored the answer
            post: { connect: { id: postId } }, // Connect to the post
          },
          select: answerModelPrismaQuery,
        })
        .then((answer) => resolve(convertQueryToAnswerModel(answer)))
        .catch((err) => reject(err));
    });
  }

  createPostComment(
    postId: number,
    authorId: number,
    comment: string
  ): Promise<CommentModel> {
    return new Promise((resolve, reject) => {
      console.log("dados, ", postId, authorId, comment);
      prisma.postComment
        .create({
          data: {
            content: comment,
            author: { connect: { id: authorId } }, // Connect to the user who authored the answer
            post: { connect: { id: postId } }, // Connect to the post
          },
          select: commentModelQuery,
        })
        .then((answer) => resolve(_transformCommentModel(answer)))
        .catch((err) => reject(err));
    });
  }

  getAnswers(postId: number, pageOptions: PageOptions): Promise<AnswerModel[]> {
    return new Promise((resolve, reject) => {
      prisma.answer
        .findMany({
          skip: pageOptions.limit * pageOptions.page,
          take: pageOptions.limit,
          where: {
            postId: postId,
          },
          orderBy: {
            updatedAt: "desc",
          },
          select: answerModelPrismaQuery,
        })
        .then((value) =>
          resolve(value.map((e) => convertQueryToAnswerModel(e)))
        )
        .catch((err) => reject(err));
    });
  }

  getPostComments(
    postId: number,
    pageOptions: PageOptions
  ): Promise<CommentModel[]> {
    return new Promise((resolve, reject) => {
      prisma.postComment
        .findMany({
          skip: pageOptions.limit * pageOptions.page,
          take: pageOptions.limit,
          where: {
            postId: postId,
          },
          orderBy: {
            updatedAt: "desc",
          },
          select: commentModelQuery,
        })
        .then((value) => resolve(value.map((e) => _transformCommentModel(e))))
        .catch((err) => reject(err));
    });
  }

  getPaginatedPosts(pageOptions: PageOptions): Promise<PostCardModel[]> {
    return new Promise((resolve, reject) => {
      console.log("dateRange ", pageOptions.dateRange);

      const tagsFilter =
        pageOptions.tags?.length != 0 ?? false
          ? {
              tags: {
                some: {
                  name: {
                    in: pageOptions.tags,
                  },
                },
              },
            }
          : {};

      prisma.post
        .findMany({
          skip: pageOptions.limit * pageOptions.page,
          take: pageOptions.limit,
          where: {
            published: true,
            OR: [
              {
                subject: { contains: pageOptions.search, mode: "insensitive" },
              },
              {
                content: { contains: pageOptions.search, mode: "insensitive" },
              },
            ],
            createdAt: {
              gte: pageOptions.dateRange?.start ?? undefined,
              lte: pageOptions.dateRange?.end ?? undefined,
            },
            ...tagsFilter,
          },
          orderBy: {
            updatedAt: "desc",
          },
          select: {
            id: true,
            author: {
              select: {
                id: true,
                name: true,
                picture: true,
              },
            },
            content: true,
            subject: true,
            published: true,
            votes: true,
            createdAt: true,
            updatedAt: true,
            tags: true,
            _count: {
              select: {
                answers: true,
              },
            },
          },
        })
        .then((posts) => {
          if (!posts) return reject("Posts not found");
          else {
            return resolve(
              posts.map<PostCardModel>(
                (post) =>
                  <PostCardModel>{
                    id: post.id,
                    subject: post.subject,
                    content: post.content,
                    published: post.published,
                    createdAt: post.createdAt,
                    updatedAt: post.updatedAt,
                    author: post.author,
                    votes: _countVotes(post.votes),
                    tags: post.tags,
                    answers: post._count.answers,
                  }
              )
            );
          }
        })
        .catch((err) => reject(err));
    });
  }

  votePostComment(
    commentId: number,
    value: number,
    authorId: number
  ): Promise<CommentModel> {
    return new Promise((resolve, reject) => {
      prisma.postComment
        .update({
          where: {
            id: commentId,
          },
          data: {
            votes: {
              upsert: {
                where: {
                  authorId: authorId,
                },
                update: {
                  value: value,
                },
                create: {
                  authorId: authorId,
                  value: value,
                },
              },
            },
          },
          select: commentModelQuery,
        })
        .then((value) => resolve(_transformCommentModel(value)))
        .catch((err) => reject(err));
    });
  }

  votePost(
    postId: number,
    value: number,
    authorId: number
  ): Promise<PostViewModel> {
    return new Promise((resolve, reject) => {
      prisma.post
        .update({
          where: {
            id: postId,
          },
          select: postViewModelQuery,
          data: {
            votes: {
              upsert: {
                where: {
                  authorId: authorId,
                },
                update: {
                  value: value,
                },
                create: {
                  authorId: authorId,
                  value: value,
                },
              },
            },
          },
        })
        .then((post) => {
          if (!post) {
            return reject("Post not found");
          } else {
            resolve(_transformPostView(post));
          }
        });
    });
  }

  getPostView(postId: number): Promise<PostViewModel> {
    return new Promise((resolve, reject) => {
      prisma.post
        .findUnique({
          where: {
            id: postId,
          },
          select: postViewModelQuery,
        })
        .then((post) => {
          if (!post) {
            return reject("Post not found");
          } else {
            resolve(_transformPostView(post));
          }
        })
        .catch((err) => reject(err));
    });
  }
}

import prisma from "../config/prismaClient";
import {
  AnswerModel,
  answerModelPrismaQuery,
  convertQueryToAnswerModel,
} from "../interfaces/AnswerModel";
import {
  CommentModel,
  _transformCommentModel,
  commentModelQuery,
} from "../interfaces/CommentModel";
import { PageOptions } from "../interfaces/PageOptions";
import { voteModelQuery } from "../interfaces/VoteModel";

export default class AnswerRepository {
  voteAnswer(
    answerId: number,
    value: number,
    authorId: number
  ): Promise<AnswerModel> {
    return new Promise((resolve, reject) => {
      console.log("Fiz o request.", answerId, value, authorId);
      prisma.answer
        .update({
          where: {
            id: answerId,
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
          select: answerModelPrismaQuery,
        })
        .then((value) => resolve(convertQueryToAnswerModel(value)))
        .catch((err) => {
          console.error("Error --> ", err);
          return reject(err);
        });
    });
  }

  voteAnswerComment(
    commentId: number,
    value: number,
    authorId: number
  ): Promise<CommentModel> {
    return new Promise((resolve, reject) => {
      console.log("Voto: ", commentId, value, authorId);

      prisma.answerComment
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

  getAnswerComments(
    answerId: number,
    pageOptions: PageOptions
  ): Promise<CommentModel[]> {
    return new Promise((resolve, reject) => {
      prisma.answerComment
        .findMany({
          skip: pageOptions.limit * pageOptions.page,
          take: pageOptions.limit,
          where: {
            answerId: answerId,
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

  createAnswerComment(
    answerId: number,
    authorId: number,
    comment: string
  ): Promise<CommentModel> {
    return new Promise((resolve, reject) => {
      console.log("dados, ", answerId, authorId, comment);
      prisma.answerComment
        .create({
          data: {
            content: comment,
            author: { connect: { id: authorId } }, // Connect to the user who authored the answer
            answer: { connect: { id: answerId } }, // Connect to the post
          },
          select: commentModelQuery,
        })
        .then((answer) => resolve(_transformCommentModel(answer)))
        .catch((err) => reject(err));
    });
  }
}

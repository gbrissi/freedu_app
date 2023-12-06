import { CommentModel } from "../interfaces/CommentModel";
import { PageOptions } from "../interfaces/PageOptions";
import { Request } from "express";
import { JwtReduced } from "../models/JwtToken";
import AnswerRepository from "../repositories/AnswerRepository";
import { AnswerModel } from "../interfaces/AnswerModel";

const answerRepo = new AnswerRepository();

export default class AnswerService {
  getAnswerComments(req: Request): Promise<CommentModel[]> {
    const answerId: number = parseInt(req.query.answerId as string);
    const pageOptions: PageOptions = JSON.parse(
      req.query.pageOptions as string
    );

    return new Promise((resolve, reject) => {
      answerRepo
        .getAnswerComments(answerId, pageOptions)
        .then((value) => resolve(value))
        .catch((err) => reject(err));
    });
  }

  sendComment(req: Request): Promise<CommentModel> {
    const answerId: number = parseInt(req.body.answerId as string);
    const answer: string = req.body.answer as string;
    const userId: number = (req.user as JwtReduced).id;

    return new Promise((resolve, reject) => {
      answerRepo
        .createAnswerComment(answerId, userId!, answer)
        .then((result) => resolve(result))
        .catch((err) => reject(err));
    });
  }

  voteAnswer(req: Request): Promise<AnswerModel> {
    const answerId: number = parseInt(req.body.answerId as string);
    const vote: boolean = req.body.vote as boolean;
    const userId: number = (req.user as JwtReduced).id;

    return new Promise((resolve, reject) => {
      answerRepo
        .voteAnswer(answerId, vote ? 1 : -1, userId!)
        .then((result) => resolve(result))
        .catch((err) => reject(err));
    });
  }

  voteComment(req: Request): Promise<CommentModel> {
    const commentId: number = parseInt(req.body.commentId as string);
    const vote: boolean = req.body.vote as boolean;
    const userId: number = (req.user as JwtReduced).id;

    return new Promise((resolve, reject) => {
      answerRepo
        .voteAnswerComment(commentId, vote ? 1 : -1, userId!)
        .then((result) => resolve(result))
        .catch((err) => reject(err));
    });
  }
}

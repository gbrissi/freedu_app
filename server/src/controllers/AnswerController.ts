import { CommentModel } from "../interfaces/CommentModel";
import { Request, Response } from "express";
import AnswerService from "../services/AnswerService";
import { AnswerModel } from "../interfaces/AnswerModel";

const answerService = new AnswerService();

export default class AnswerController {
  sendAnswerComment(req: Request, res: Response) {
    answerService
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

  voteAnswerComment(req: Request, res: Response) {
    answerService
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

  voteAnswer(req: Request, res: Response) {
    answerService
      .voteAnswer(req)
      .then((answer: AnswerModel) =>
        res
          .status(200)
          .send({ message: "Successfully voted answer", data: answer })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  getAnswerComments(req: Request, res: Response) {
    answerService
      .getAnswerComments(req)
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
}

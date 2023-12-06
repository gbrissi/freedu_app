import { Request, Response } from "express";
import PostController from "../controllers/PostController";
import isLoggedIn from "../middlewares/isLoggedIn";
import AnswerController from "../controllers/AnswerController";

const express = require("express");
const router = express.Router();

const answerController = new AnswerController();

router.get("/id/comments", answerController.getAnswerComments);
router.post("/id/comments", isLoggedIn, answerController.sendAnswerComment);
router.post("/id/votes", isLoggedIn, answerController.voteAnswer);
router.post(
  "/id/comments/id/votes",
  isLoggedIn,
  answerController.voteAnswerComment
);

export default router;

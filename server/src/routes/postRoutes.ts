import { Request, Response } from "express";
import PostController from "../controllers/PostController";
import isLoggedIn from "../middlewares/isLoggedIn";
import passport from "passport";

const express = require("express");
const router = express.Router();

const postController = new PostController();

router.post("/", isLoggedIn, postController.createPost);
router.get("/id", postController.getPostView);
router.get("/id/comments", postController.getPostComments);
router.post("/id/comments", isLoggedIn, postController.sendPostComment);
router.get("/id/answers", postController.getAnswers);
router.post("/id/answers", isLoggedIn, postController.sendAnswer);
router.get("/cards/paginated", postController.getPaginatedPosts);
router.post("/id/votes", isLoggedIn, postController.votePost);
router.post(
  "/id/comments/id/votes",
  isLoggedIn,
  postController.votePostComment
);

export default router;

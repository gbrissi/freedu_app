import { Request, Response } from "express";
import PostController from "../controllers/PostController";
import isLoggedIn from "../middlewares/isLoggedIn";
import passport from "passport";

const express = require("express");
const router = express.Router();

const postController = new PostController();

router.get("/", isLoggedIn, (req: Request, res: Response) =>
  res.status(200).send({ message: "OK" })
);

router.post("/", isLoggedIn, postController.createPost);
router.get("/cards/paginated", postController.getPaginatedPosts);

export default router;

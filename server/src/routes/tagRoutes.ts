import TagController from "../controllers/TagController";

const express = require("express");
const router = express.Router();

const tagController = new TagController();

router.get("/", tagController.getTags);

export default router;

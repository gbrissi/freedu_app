import UserController from "../controllers/UserController";
import isLoggedIn from "../middlewares/isLoggedIn";

const express = require("express");
const router = express.Router();

const userController = new UserController();

router.get("/id", userController.getUserProfile);
router.patch("/me", isLoggedIn, userController.updateUserProfile);

export default router;

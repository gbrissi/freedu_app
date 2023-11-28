import { NextFunction, Request, Response } from "express";
import passport from "passport";
import AuthController from "../controllers/AuthController";

const express = require("express");
const router = express.Router();
const authController = new AuthController();

router.post("/login/password", authController.localLogin);
router.post("/register/password", authController.localRegister);
router.post("/login/refresh", authController.refreshJwt);
router.get(
  "/login/google",
  passport.authenticate("google", { scope: "profile", session: false })
);
router.get(
  "/login/google/callback",
  passport.authenticate("google", { session: false }),
  authController.googleLoginCallback
);

export default router;

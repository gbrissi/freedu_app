import { Request, Response } from "express";
import UserService from "../services/UserService";
import { UserProfileModel } from "../interfaces/UserProfileModel";

const userService = new UserService();

export default class UserController {
  getUserProfile(req: Request, res: Response) {
    userService
      .getUserProfile(req)
      .then((user: UserProfileModel) =>
        res.status(200).send({ message: "Successfully got user", data: user })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  updateUserProfile(req: Request, res: Response) {
    userService
      .updateUserProfile(req)
      .then((user: UserProfileModel) =>
        res.status(200).send({ message: "Successfully updated user", data: user })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }
}

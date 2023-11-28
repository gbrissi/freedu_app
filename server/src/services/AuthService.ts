import { Request } from "express";
import { JwtToken, createJwtToken } from "../models/JwtToken";
import type { User } from "@prisma/client";
import FieldValidator from "../models/FieldValidator";
import UserRepository from "../repositories/UserRepository";
import UserEssential from "../models/UserEssential";

const userRepo = new UserRepository();

export default class AuthService {
  localRegister(req: Request): Promise<JwtToken> {
    const username = req.body.username;
    const password = req.body.password;
    const name = req.body.name;
    console.log("Dados: ", username, password, name);

    return new Promise((resolve, reject) => {
      UserEssential.createInstance({
        username,
        password,
        name,
      })
        .then((info: UserEssential) => userRepo.create(info))
        .then((user: User) => createJwtToken(user))
        .then((token: JwtToken) => resolve(token))
        .catch((err: Error) => {
          console.log("erro: ", err);
          reject(err);
        });
    });
  }
}

import { User } from "@prisma/client";
import passport from "passport";
import { Request, Response } from "express";
import { JwtToken, createJwtToken } from "../models/JwtToken";
import AuthService from "../services/AuthService";

const authService = new AuthService();

export default class AuthController {
  refreshJwt(req: Request, res: Response) {
    passport.authenticate(
      "jwt",
      { session: false },
      (err: any, user: User, _: any) => {
        console.log("cheguei aqui?: ", user);
        function _returnJwt() {
          const jwtToken: JwtToken = createJwtToken(user);

          return res.status(200).send({
            message: "New token successfully issued",
            data: jwtToken,
          });
        }

        return err
          ? res.status(500).send({ message: "Server error", error: err })
          : _returnJwt();
      }
    )(req, res);
  }

  localLogin(req: Request, res: Response) {
    return passport.authenticate(
      "local",
      { session: false },
      (err: any, user: User, _: any) => {
        console.log("user: ", user);
        if (err) {
          return res.status(500).send({
            message: "Server error",
            error: err,
          });
        } else if (!user) {
          return res.status(404).send({
            message: "User not found",
            error: "User has not been found",
          });
        } else {
          req.login(user, { session: false }, (err) => {
            if (err) {
              return res.status(500).send({
                message: "Login middleware error",
                error: err,
              });
            } else {
              const jwtToken: JwtToken = createJwtToken(user);

              return res.status(200).send({
                message: "Successfully logged in",
                data: jwtToken,
              });
            }
          });
        }
      }
    )(req, res);
  }

  localRegister(req: Request, res: Response) {
    authService
      .localRegister(req)
      .then((token: JwtToken) =>
        res
          .status(200)
          .send({ message: "Account successfully registered", data: token })
      )
      .catch((err: any) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }

  googleLogin(req: Request, res: Response) {
    console.log("to tentando fazer login");
    return passport.authenticate("google", { scope: "profile" })(req, res);
  }

  googleLoginCallback(req: Request, res: Response) {
    console.log("to no callback");
    // TODO: Create Access and Refresh token, then send it to the client.
    res.status(200).send({ message: "OK" });
  }
}

import passport from "passport";
import { Strategy as LocalStrategy } from "passport-local";
import { Strategy as JWTStrategy, ExtractJwt } from "passport-jwt";
import { Strategy as GoogleStrategy } from "passport-google-oauth20";
import prisma from "./prismaClient";
import crypto from "crypto";
import jwt, { JwtPayload } from "jsonwebtoken";
import { Request } from "express";

// Passport strategies
passport.use(
  new LocalStrategy(async function verify(
    username: string,
    password: string,
    cb
  ) {
    const user = await prisma.user.findUnique({ where: { username } });
    const authError: string = "Incorrect username and/or password.";

    // Check if user was found with the provided username.
    if (user == null) {
      return cb(null, false, {
        message: authError,
      });
    }

    // Hashed password must be a buffer for comparison
    const userBufferPassword: Buffer = Buffer.from(user.password, "hex");

    // Validate user password.
    crypto.scrypt(
      password,
      process.env.PASSWORD_SALT as string,
      64,
      (err, hashedPassword: Buffer) => {
        console.log("resultado: ", hashedPassword.toString("hex"));

        if (err) return cb(err);
        else if (!crypto.timingSafeEqual(userBufferPassword, hashedPassword)) {
          return cb(null, false, {
            message: authError,
          });
        } else {
          return cb(null, user);
        }
      }
    );
  })
);

passport.use(
  new GoogleStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
      callbackURL: "http://localhost:3000/auth/login/google/callback",
    },
    function (accessToken, refreshToken, profile, cb) {
      console.log("profile: ", profile);
      // TODO: 
      // return cb(null, profile);
    }
  )
);

passport.use(
  new JWTStrategy(
    {
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      // jwtFromRequest: (req: Request): string | null => {
      //   let token: string | null = null;

      //   if (req.headers.authorization != null) {
      //     token = req.headers.authorization.split("Bearer ")[1];
      //   }

      //   let jwtPayload: string | null = null;
      //   if (token) {
      //     jwtPayload = jwt.verify(token, process.env.JWT_SECRET_KEY!) as string;
      //   }

      //   console.log("Payload: ", jwtPayload);
      //   return jwtPayload;
      // },
      secretOrKey: process.env.JWT_SECRET_KEY!,
    },
    function (jwtPayload, cb) {
      // TODO: Check if user is blocked?
      console.log("ta aqui o payload: ", jwtPayload);
      return prisma.user
        .findUnique({
          where: {
            id: jwtPayload.id,
          },
          select: {
            id: true,
            username: true,
          },
        })
        .then((user: any) => {
          return cb(null, user);
        })
        .catch((err) => {
          return cb(err);
        });
    }
  )
);

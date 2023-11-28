import prisma from "../config/prismaClient";
import type { User, Picture } from "@prisma/client";
import UserEssential from "../models/UserEssential";

interface UserPublicInfo {
  id: number;
  description: string | null;
  username: string;
  picture?: Picture;
  name: string;
}

export default class UserRepository {
  create(info: UserEssential): Promise<User> {
    return new Promise((resolve, reject) => {
      prisma.user
        .create({
          data: {
            name: info.name,
            username: info.username,
            password: info.hashedPassword,
          },
        })
        .then((user: User) => resolve(user))
        .catch((err) => reject(err));
    });
  }

  getPublicInfo(userId: number): Promise<UserPublicInfo> {
    return new Promise((resolve, reject) => {
      prisma.user
        .findUnique({
          where: {
            id: userId,
          },
          select: {
            id: true,
            description: true,
            username: true,
            picture: true,
            name: true,
          },
        })
        .then((user) => {
          if (!user) {
            return reject("User public info has not been found.");
          } else {
            return resolve(<UserPublicInfo>{ ...user });
          }
        })
        .catch((err) => reject(err));
    });
  }
}

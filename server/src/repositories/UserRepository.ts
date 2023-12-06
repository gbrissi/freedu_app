import prisma from "../config/prismaClient";
import type { User, Picture } from "@prisma/client";
import UserEssential from "../models/UserEssential";
import {
  UserProfileModel,
  convertQueryToUserProfileModel,
  userProfileModelQuery,
} from "../interfaces/UserProfileModel";
import { StoredPicture } from "../interfaces/StoredPicture";
import { pictureModelQuery } from "../interfaces/PictureModel";

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

  updateProfile({
    userId,
    name,
    email,
    description,
    picture,
  }: {
    userId: number;
    name: string;
    email?: string;
    description?: string;
    picture?: StoredPicture;
  }): Promise<UserProfileModel> {
    const pictureQuery =
      picture != null
        ? {
            picture: {
              create: {
                name: picture!.name,
                original: picture!.url,
                filetype: picture!.fileType,
              },
            },
          }
        : {};

    return new Promise((resolve, reject) => {
      prisma.user
        .update({
          where: {
            id: userId,
          },
          data: {
            name: name,
            email: email,
            description: description,
            ...pictureQuery,
          },
          select: userProfileModelQuery,
        })
        .then((value) => {
          if (!value) return reject("User not found");
          else resolve(convertQueryToUserProfileModel(value));
        })
        .catch((err) => reject(err));
    });
  }

  getProfile(userId: number): Promise<UserProfileModel> {
    return new Promise((resolve, reject) => {
      prisma.user
        .findUnique({
          where: {
            id: userId,
          },
          select: userProfileModelQuery,
        })
        .then((value) => {
          if (!value) reject("Profile not found");
          else resolve(convertQueryToUserProfileModel(value));
        })
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

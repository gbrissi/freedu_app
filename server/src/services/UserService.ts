import { Request } from "express";
import UserRepository from "../repositories/UserRepository";
import { JwtReduced } from "../models/JwtToken";
import { UserProfileModel } from "../interfaces/UserProfileModel";
import { ExternalPicture } from "../interfaces/ExternalPicture";
import { StoredPicture } from "../interfaces/StoredPicture";
import CloudStorageManager from "../helpers/CloudStorageManager";

const userRepo = new UserRepository();

export default class UserService {
  getUserProfile(req: Request): Promise<UserProfileModel> {
    const userId: number = parseInt(req.query.userId as string);

    return new Promise((resolve, reject) => {
      userRepo
        .getProfile(userId)
        .then((value) => resolve(value))
        .catch((err) => reject(err));
    });
  }

  async updateUserProfile(req: Request): Promise<UserProfileModel> {
    const userId: number = (req.user as JwtReduced).id;
    const name: string = req.body.name;
    const email: string | undefined = req.body.email;
    const description: string | undefined = req.body.description;
    const externalPicture: ExternalPicture | undefined = req.body.picture;
    let picture: StoredPicture | undefined;

    console.log("Cheguei aqui", userId, name, email, description, externalPicture)

    if (externalPicture != null) {
      console.log("just got inside here.", externalPicture, typeof externalPicture)
      picture = await CloudStorageManager.createPic(externalPicture!);
    }

    console.log("still doin s...")

    return new Promise((resolve, reject) => {
      userRepo
        .updateProfile({
          userId: userId,
          name: name,
          email: email,
          description: description,
          picture: picture,
        })
        .then((value) => resolve(value))
        .catch((err) => reject(err));
    });
  }
}

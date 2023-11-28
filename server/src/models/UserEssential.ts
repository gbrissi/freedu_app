import crypto from "crypto";
import FieldValidator from "./FieldValidator";

export default class UserEssential {
  name: string;
  username: string;
  hashedPassword: string;

  constructor({
    name,
    username,
    hashedPassword,
  }: {
    name: string;
    username: string;
    hashedPassword: string;
  }) {
    (this.name = name),
      (this.username = username),
      (this.hashedPassword = hashedPassword);
  }

  public static async createInstance({
    username,
    password,
    name,
  }: {
    username: string;
    password: string;
    name: string;
  }): Promise<UserEssential> {
    return new Promise((resolve, reject) => {
      if (!FieldValidator.password(password)) {
        return reject("Weak password");
      }

      crypto.scrypt(
        password,
        process.env.PASSWORD_SALT as string,
        64,
        (err, hashedPassword: Buffer) => {
          if (err) return reject(err);
          else {
            resolve(
              new UserEssential({
                hashedPassword: hashedPassword.toString("hex"),
                username,
                name,
              })
            );
          }
        }
      );
    });
  }
}

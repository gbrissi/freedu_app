import type { Tag } from "@prisma/client";
import prisma from "../config/prismaClient";

export default class TagRepository {
  getTags(): Promise<Tag[]> {
    return new Promise((resolve, reject) => {
      prisma.tag
        .findMany()
        .then((tags: Tag[]) => resolve(tags))
        .catch((err) => reject(err));
    });
  }
}

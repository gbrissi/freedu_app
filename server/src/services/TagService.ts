import TagRepository from "../repositories/TagRepository";
import { Tag } from "@prisma/client";

const tagRepo = new TagRepository();

export default class TagService {
  getTags(): Promise<Tag[]> {
    return new Promise((resolve, reject) => {
      tagRepo
        .getTags()
        .then((tags: Tag[]) => resolve(tags))
        .catch((err) => reject(err));
    });
  }
}

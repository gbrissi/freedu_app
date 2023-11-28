import type { Tag } from "@prisma/client";
import TagService from "../services/TagService";
import { Request, Response } from "express";

const tagService = new TagService();

export default class TagController {
  getTags(_: Request, res: Response) {
    tagService
      .getTags()
      .then((tags: Tag[]) =>
        res
          .status(200)
          .send({ message: "Successfully got available tags", data: tags })
      )
      .catch((err) =>
        res.status(500).send({ message: "Server error", error: err })
      );
  }
}

import type { Tag } from "@prisma/client";
import { AuthorModel } from "./AuthorModel";

export interface PostCardModel {
  id: number;
  subject: string;
  content?: string;
  published: boolean;
  createdAt: Date;
  updatedAt: Date;
  author: AuthorModel;
  votes: number;
  tags: Tag[];
  answers: number;
}

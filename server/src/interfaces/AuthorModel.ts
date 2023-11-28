import type { Picture } from "@prisma/client";

export interface AuthorModel {
  id: number;
  name: string;
  picture: Picture;
}

import { AuthorModel } from "./AuthorModel";

export interface VoteModel {
  id: number;
  value: number;
  author: AuthorModel;
  createdAt: Date;
  updatedAt: Date;
}

export const voteModelQuery = {
  id: true,
  value: true,
  author: {
    select: {
      id: true,
      name: true,
      picture: true,
    },
  },
  createdAt: true,
  updatedAt: true,
};

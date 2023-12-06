import { AuthorModel } from "./AuthorModel";
import { VoteModel, voteModelQuery } from "./VoteModel";

export const commentModelQuery = {
  id: true,
  author: {
    select: {
      id: true,
      name: true,
      picture: true,
    },
  },
  content: true,
  votes: {
    select: voteModelQuery,
  },
  createdAt: true,
  updatedAt: true,
};

export function _transformCommentModel(comment: any): CommentModel {
  return <CommentModel>{
    id: comment.id,
    author: comment.author,
    content: comment.content,
    votes: comment.votes,
    createdAt: comment.createdAt,
    updatedAt: comment.updatedAt,
  };
}

export interface CommentModel {
  id: number;
  author: AuthorModel;
  content: string;
  votes: VoteModel[];
  createdAt: Date;
  updatedAt: Date;
}

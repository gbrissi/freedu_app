import { AuthorModel } from "./AuthorModel";
import { VoteModel, voteModelQuery } from "./VoteModel";

export const answerModelPrismaQuery = {
  id: true,
  content: true,
  votes: {
    select: voteModelQuery,
  },
  author: {
    select: {
      id: true,
      name: true,
      picture: true,
    },
  },
  _count: {
    select: {
      comments: true,
    },
  },
  createdAt: true,
  updatedAt: true,
};

export function convertQueryToAnswerModel(answer: any): AnswerModel {
  console.log(
    "Cheguei aqui. ",
    answer.id,
    answer.content,
    answer.votes,
    answer.author,
    answer.commentsCount,
    answer.createdAt,
    answer.updatedAt
  );
  return <AnswerModel>{
    id: answer.id,
    content: answer.content,
    votes: answer.votes,
    author: answer.author,
    commentsCount: answer._count.comments,
    createdAt: answer.createdAt,
    updatedAt: answer.updatedAt,
  };
}

export interface AnswerModel {
  id: number;
  content: string;
  votes: VoteModel[];
  commentsCount: number;
  author: AuthorModel;
  createdAt: Date;
  updatedAt: Date;
}

import type { Tag } from "@prisma/client";
import { AuthorModel } from "./AuthorModel";
import { VoteModel, voteModelQuery } from "./VoteModel";

export const postViewModelQuery = {
  id: true,
  subject: true,
  content: true,
  votes: {
    select: voteModelQuery,
  },
  tags: true,
  createdAt: true,
  updatedAt: true,
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
};

export function _transformPostView(post: any): PostViewModel {
  return <PostViewModel>{
    id: post.id,
    subject: post.subject,
    content: post.content,
    votes: post.votes,
    author: post.author,
    messagesCount: post._count.comments,
    tags: post.tags,
    createdAt: post.createdAt,
    updatedAt: post.updatedAt,
  };
}

export interface PostViewModel {
  id: number;
  author: AuthorModel;
  subject: string;
  content?: string;
  votes: VoteModel[];
  messagesCount: number;
  tags: Tag[];
  createdAt: Date;
  updatedAt: Date;
}

import prisma from "../config/prismaClient";
import type { Post, Picture, Vote, Tag } from "@prisma/client";
import { PageOptions } from "../interfaces/PageOptions";
import { PostCardModel } from "../interfaces/PageCardModel";

function _countVotes(votes: Vote[]): number {
  let count: number = 0;
  for (let vote of votes) {
    count += vote.value;
  }

  return count;
}

export default class PostRepository {
  createPost({
    authorId,
    subject,
    description,
    tags,
  }: {
    authorId: number;
    subject: string;
    description: string;
    tags: any, // TODO: 
  }): Promise<Post> {
    return new Promise((resolve, reject) => {
      prisma.post
        .create({
          data: {
            subject: subject,
            content: description,
            authorId: authorId,
          },
        })
        .then((post: Post | null) => {
          if (!post) return reject("Post creation error");
          else return resolve(post);
        })
        .catch((err) => reject(err));
    });
  }

  getPaginatedPosts(pageOptions: PageOptions): Promise<PostCardModel[]> {
    return new Promise((resolve, reject) => {
      prisma.post
        .findMany({
          skip: pageOptions.limit * pageOptions.page,
          take: pageOptions.limit,
          where: {
            published: true,
          },
          orderBy: {
            updatedAt: "desc",
          },
          select: {
            id: true,
            author: {
              select: {
                id: true,
                name: true,
                picture: true,
              },
            },
            content: true,
            subject: true,
            published: true,
            votes: true,
            createdAt: true,
            updatedAt: true,
            tags: true,
            _count: {
              select: {
                answers: true,
              },
            },
          },
        })
        .then((posts) => {
          if (!posts) return reject("Posts not found");
          else {
            return resolve(
              posts.map<PostCardModel>(
                (post) =>
                  <PostCardModel>{
                    id: post.id,
                    subject: post.subject,
                    content: post.content,
                    published: post.published,
                    createdAt: post.createdAt,
                    updatedAt: post.updatedAt,
                    author: post.author,
                    votes: _countVotes(post.votes),
                    tags: post.tags,
                    answers: post._count.answers,
                  }
              )
            );
          }
        })
        .catch((err) => reject(err));
    });
  }

  getPostTagCount(): Promise<number> {
    return new Promise((resolve, reject) => {
      prisma.tag.count({
        where: {
          post: {},
        },
      });
    });
  }
}

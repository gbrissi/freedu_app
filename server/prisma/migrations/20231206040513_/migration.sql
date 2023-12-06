/*
  Warnings:

  - A unique constraint covering the columns `[authorId,postCommentId]` on the table `PostCommentVote` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "PostCommentVote_authorId_postCommentId_key" ON "PostCommentVote"("authorId", "postCommentId");

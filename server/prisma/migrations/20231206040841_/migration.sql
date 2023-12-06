/*
  Warnings:

  - A unique constraint covering the columns `[authorId,answerCommentId]` on the table `AnswerCommentVote` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[authorId,answerId]` on the table `AnswerVote` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[authorId,postId]` on the table `PostVote` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "AnswerCommentVote_authorId_answerCommentId_key" ON "AnswerCommentVote"("authorId", "answerCommentId");

-- CreateIndex
CREATE UNIQUE INDEX "AnswerVote_authorId_answerId_key" ON "AnswerVote"("authorId", "answerId");

-- CreateIndex
CREATE UNIQUE INDEX "PostVote_authorId_postId_key" ON "PostVote"("authorId", "postId");

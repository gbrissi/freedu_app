/*
  Warnings:

  - You are about to drop the column `blockId` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[userId]` on the table `Blocked` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `userId` to the `Blocked` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_blockId_fkey";

-- DropIndex
DROP INDEX "User_blockId_key";

-- AlterTable
ALTER TABLE "Blocked" ADD COLUMN     "userId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Post" ALTER COLUMN "published" SET DEFAULT true;

-- AlterTable
ALTER TABLE "Report" ADD COLUMN     "answerCommentId" INTEGER,
ADD COLUMN     "postCommentId" INTEGER;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "blockId";

-- AlterTable
ALTER TABLE "Vote" ADD COLUMN     "answerCommentId" INTEGER,
ADD COLUMN     "postCommentId" INTEGER;

-- CreateTable
CREATE TABLE "PostComment" (
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "authorId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "postId" INTEGER NOT NULL,

    CONSTRAINT "PostComment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnswerComment" (
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "authorId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "answerId" INTEGER NOT NULL,

    CONSTRAINT "AnswerComment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PostComment_authorId_key" ON "PostComment"("authorId");

-- CreateIndex
CREATE UNIQUE INDEX "PostComment_postId_key" ON "PostComment"("postId");

-- CreateIndex
CREATE UNIQUE INDEX "AnswerComment_authorId_key" ON "AnswerComment"("authorId");

-- CreateIndex
CREATE UNIQUE INDEX "AnswerComment_answerId_key" ON "AnswerComment"("answerId");

-- CreateIndex
CREATE UNIQUE INDEX "Blocked_userId_key" ON "Blocked"("userId");

-- AddForeignKey
ALTER TABLE "PostComment" ADD CONSTRAINT "PostComment_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostComment" ADD CONSTRAINT "PostComment_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_answerCommentId_fkey" FOREIGN KEY ("answerCommentId") REFERENCES "AnswerComment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_postCommentId_fkey" FOREIGN KEY ("postCommentId") REFERENCES "PostComment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnswerComment" ADD CONSTRAINT "AnswerComment_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnswerComment" ADD CONSTRAINT "AnswerComment_answerId_fkey" FOREIGN KEY ("answerId") REFERENCES "Answer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_answerCommentId_fkey" FOREIGN KEY ("answerCommentId") REFERENCES "AnswerComment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_postCommentId_fkey" FOREIGN KEY ("postCommentId") REFERENCES "PostComment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Blocked" ADD CONSTRAINT "Blocked_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

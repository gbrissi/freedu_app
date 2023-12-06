/*
  Warnings:

  - You are about to drop the `Option` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `option` to the `Report` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "ReportOption" AS ENUM ('MISINFORMATION', 'VIOLENT_CONTENT', 'INAPPROPRIATE_NAME', 'OTHER');

-- DropForeignKey
ALTER TABLE "Option" DROP CONSTRAINT "Option_reportId_fkey";

-- DropIndex
DROP INDEX "PostComment_authorId_key";

-- DropIndex
DROP INDEX "PostComment_postId_key";

-- AlterTable
ALTER TABLE "Report" ADD COLUMN     "option" "ReportOption" NOT NULL;

-- DropTable
DROP TABLE "Option";

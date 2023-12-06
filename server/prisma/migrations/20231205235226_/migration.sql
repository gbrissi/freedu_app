/*
  Warnings:

  - You are about to drop the column `urlsId` on the `Picture` table. All the data in the column will be lost.
  - You are about to drop the `PictureReferences` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `original` to the `Picture` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Picture" DROP CONSTRAINT "Picture_urlsId_fkey";

-- DropIndex
DROP INDEX "Picture_urlsId_key";

-- AlterTable
ALTER TABLE "Picture" DROP COLUMN "urlsId",
ADD COLUMN     "original" VARCHAR(255) NOT NULL,
ADD COLUMN     "small" VARCHAR(255),
ADD COLUMN     "thumbnail" VARCHAR(255);

-- DropTable
DROP TABLE "PictureReferences";

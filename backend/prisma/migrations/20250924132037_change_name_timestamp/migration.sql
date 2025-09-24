/*
  Warnings:

  - You are about to drop the column `createdAt` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `updatedBy` on the `barang` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `barang_kategori` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `barang_kategori` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `barang_kategori` table. All the data in the column will be lost.
  - You are about to drop the column `updatedBy` on the `barang_kategori` table. All the data in the column will be lost.
  - Added the required column `created_by` to the `barang` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_by` to the `barang` table without a default value. This is not possible if the table is not empty.
  - Added the required column `created_by` to the `barang_kategori` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_by` to the `barang_kategori` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."barang" DROP COLUMN "createdAt",
DROP COLUMN "createdBy",
DROP COLUMN "updatedAt",
DROP COLUMN "updatedBy",
ADD COLUMN     "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "created_by" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_by" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."barang_kategori" DROP COLUMN "createdAt",
DROP COLUMN "createdBy",
DROP COLUMN "updatedAt",
DROP COLUMN "updatedBy",
ADD COLUMN     "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "created_by" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_by" TEXT NOT NULL;

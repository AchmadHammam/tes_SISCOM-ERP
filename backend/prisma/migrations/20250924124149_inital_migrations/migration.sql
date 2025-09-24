-- CreateTable
CREATE TABLE "public"."barang" (
    "id" SERIAL NOT NULL,
    "nama" TEXT NOT NULL,
    "kategori_id" INTEGER NOT NULL,
    "kelompok_barang" TEXT NOT NULL,
    "stok" INTEGER NOT NULL,
    "harga" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT NOT NULL,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "updatedBy" TEXT NOT NULL,

    CONSTRAINT "barang_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."barang_kategori" (
    "id" SERIAL NOT NULL,
    "nama" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" TEXT NOT NULL,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "updatedBy" TEXT NOT NULL,

    CONSTRAINT "barang_kategori_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."barang" ADD CONSTRAINT "barang_kategori_id_fkey" FOREIGN KEY ("kategori_id") REFERENCES "public"."barang_kategori"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

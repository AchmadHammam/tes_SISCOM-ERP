import { createZodDto } from 'nestjs-zod';
import z from 'zod';

export const barangSchemaValidaton = z.object({
  kategori_id: z.number().min(1, { message: 'Kategori barang harus diisi' }),
  kelompok_barang: z
    .string()
    .min(1, { message: 'Kelompok barang harus diisi' }),
  nama: z.string().min(1, { message: 'Nama barang harus diisi' }),
  harga: z.number().min(1, { message: 'Harga barang harus diisi' }),
  stok: z.number().min(1, { message: 'Stok barang harus diisi' }),
});

export const updateBarangSchemaValidaton = barangSchemaValidaton.partial();
export const deleteBarangSchemaValidaton = z.object({
  id: z.number().array().min(1),
});

export type updateBarangType = z.infer<typeof updateBarangSchemaValidaton>;
export class UpdateBarangDto extends createZodDto(
  updateBarangSchemaValidaton,
) {}

export type deleteBarangType = z.infer<typeof deleteBarangSchemaValidaton>;
export class DeleteBarangDto extends createZodDto(deleteBarangSchemaValidaton) {}

export type barangType = z.infer<typeof barangSchemaValidaton>;
export class BarangDto extends createZodDto(barangSchemaValidaton) {}

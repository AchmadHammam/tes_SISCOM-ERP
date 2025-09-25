import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { barangType } from 'src/common/dto/barang.dto';

@Injectable()
export class BarangService {
  constructor(private prisma: PrismaService) {}
  async getAllBarang(page: number, limit: number, find?: string) {
    const skip = (page - 1) * limit;
    const data = await this.prisma.barang.findMany({
      where: {
        nama: find ? { contains: find, mode: 'insensitive' } : undefined,
      },
      select: {
        id: true,
        nama: true,
        harga: true,
        stok: true,
        kategori: {
          select: {
            id: true,
            nama: true,
          },
        },
        kelompokBarang: true,
      },
      skip: skip,
      take: limit,
    });
    const total = await this.prisma.barang.aggregate({
      _sum: {
        harga: true,
        stok: true,
      },
    });
    const totalData = await this.prisma.barang.count();
    return {
      data,
      meta: {
        total: totalData,
        page,
        limit,
        totalHarga: total._sum.harga,
        totalStok: total._sum.stok,
        totalPage: Math.ceil(totalData / limit),
      },
    };
  }
  async createBarang(data: barangType) {
    // check katregori id
    const kategori = await this.prisma.barangKategori.findUnique({
      where: { id: data.kategori_id },
    });
    if (!kategori) {
      throw new Error('Kategori barang tidak ditemukan');
    }
    //create barang
    const barang = await this.prisma.barang.create({
      data: {
        nama: data.nama,
        harga: data.harga,  
        stok: data.stok,
        kategoriId: data.kategori_id ,  
        kelompokBarang: data.kelompok_barang,  
        createdBy: 'system',
        updatedBy: 'system',
      },
    });
    return barang;
  }
  async updateBarang(id: number, data: barangType) {
    const barang = await this.prisma.barang.findUnique({
      where: { id: id },
    });
    if (!barang) {
      throw new Error('Barang tidak ditemukan');
    }
    const updatedBarang = await this.prisma.barang.update({
      where: { id: id },
      data: {
        nama: data.nama,
        harga: data.harga,
        stok: data.stok,
        kategoriId: data.kategori_id,
        kelompokBarang: data.kelompok_barang,
        updatedBy: 'system',
      },
    });
    return updatedBarang;
  }
  async findBarang(id: number) {
    const barang = await this.prisma.barang.findUnique({
      where: { id: id },
    });
    if (!barang) {
      throw new Error('Barang tidak ditemukan');
    }
    return barang;
  }
  async deleteBarang(id: number) {
    const barang = await this.prisma.barang.findUnique({
      where: { id: id },
    });
    if (!barang) {
      throw new Error('Barang tidak ditemukan');
    }
    const deletedBarang = await this.prisma.barang.delete({
      where: { id: id },
    });
    return deletedBarang;
  }
}

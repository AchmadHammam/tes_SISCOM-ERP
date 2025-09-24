import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

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
}

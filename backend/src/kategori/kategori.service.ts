import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class KategoriService {
  constructor(private prisma: PrismaService) {}
  async findAll(page: number, limit: number) {
    const data = await this.prisma.barangKategori.findMany({
      select: {
        id: true,
        nama: true,
      },
      skip: (page - 1) * limit,
      take: limit,
    });

    const totalData = await this.prisma.barangKategori.count();
    return {
      data,
      meta: {
        total: totalData,
        page,
        limit,
        totalPage: Math.ceil(totalData / limit),
      },
    };
  }
}

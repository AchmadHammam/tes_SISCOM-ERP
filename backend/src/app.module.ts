import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { BarangModule } from './barang/barang.module';
import { PrismaModule } from './prisma/prisma.module';
import { KategoriModule } from './kategori/kategori.module';

@Module({
  imports: [BarangModule,PrismaModule, KategoriModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

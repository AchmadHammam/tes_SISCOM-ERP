import { Module } from '@nestjs/common';
import { BarangController } from './barang.controller';
import { BarangService } from './barang.service';

@Module({
  imports: [],
  controllers: [BarangController],
  providers: [BarangService],
  exports: [],
})
export class BarangModule {}

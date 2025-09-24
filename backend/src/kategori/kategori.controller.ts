import { BadRequestException, Controller, Get, Query } from '@nestjs/common';
import { KategoriService } from './kategori.service';
import { PaginationDto } from 'src/common/dto/pagination.dto';

@Controller('kategori-barang')
export class KategoriController {
  constructor(private kategoriService: KategoriService) {}
  @Get()
  getAllKategori(@Query() query: PaginationDto) {
    const parsedQueryValidation = PaginationDto.schema.safeParse(query);
    if (!parsedQueryValidation.success) {
      throw new BadRequestException(parsedQueryValidation.error);
    }
    return this.kategoriService.findAll(1, 10);
  }
}

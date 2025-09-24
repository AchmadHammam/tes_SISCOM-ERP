import { BadRequestException, Controller, Get, Query } from '@nestjs/common';
import { BarangService } from './barang.service';
import {
  PaginationFindDto,
  PaginationFindSchema,
} from 'src/common/dto/pagination.dto';

@Controller('barang')
export class BarangController {
  constructor(private barangService: BarangService) {}
  @Get()
  getAllBarang(@Query() query: PaginationFindDto) {
    const parseqQueryValidation = PaginationFindSchema.safeParse(query);
    if (!parseqQueryValidation.success) {
      throw new BadRequestException(parseqQueryValidation.error);
    }
    const parsedQuery = parseqQueryValidation.data;

    return this.barangService.getAllBarang(
      parsedQuery.page,
      parsedQuery.limit,
      parsedQuery.find,
    );
  }
}

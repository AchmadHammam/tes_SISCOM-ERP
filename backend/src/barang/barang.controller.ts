import { BadRequestException, Controller, Get, Post, Query,Body, Put } from '@nestjs/common';
import { BarangService } from './barang.service';
import {
  PaginationFindDto,
  PaginationFindSchema,
} from 'src/common/dto/pagination.dto';
import { BarangDto, barangSchemaValidaton } from 'src/common/dto/barang.dto';

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
  @Post()
  createBarang(@Body() data: BarangDto) {
    console.log(data);

    const parseBodyValidation = barangSchemaValidaton.safeParse(data);
    if (!parseBodyValidation.success) {
      throw new BadRequestException(parseBodyValidation.error);
    }
    const parsedBody = parseBodyValidation.data;
    return this.barangService.createBarang(parsedBody);
  }
  @Put(':id')
  updateBarang(@Body() data: BarangDto, @Query('id') id: number) {
    
    const parseBodyValidation = barangSchemaValidaton.safeParse(data);
    if (!parseBodyValidation.success) {
      throw new BadRequestException(parseBodyValidation.error);
    }
    const parsedBody = parseBodyValidation.data;
    return this.barangService.updateBarang(id, parsedBody);
  }
  @Get(':id')
  findBarang(@Query('id') id: number) {
    return this.barangService.findBarang(id);
  }
  @Get('delete/:id')
  deleteBarang(@Query('id') id: number) {
    return this.barangService.deleteBarang(id);
  }
}

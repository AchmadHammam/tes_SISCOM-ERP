import {
  BadRequestException,
  Controller,
  Get,
  Post,
  Query,
  Body,
  Put,
  Param,
  Delete,
} from '@nestjs/common';
import { BarangService } from './barang.service';
import {
  PaginationFindDto,
  PaginationFindSchema,
} from 'src/common/dto/pagination.dto';
import {
  BarangDto,
  barangSchemaValidaton,
  DeleteBarangDto,
  deleteBarangSchemaValidaton,
  updateBarangSchemaValidaton,
} from 'src/common/dto/barang.dto';

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
  updateBarang(@Body() data: BarangDto, @Param('id') id: string) {
    const parseBodyValidation = updateBarangSchemaValidaton.safeParse(data);
    if (!parseBodyValidation.success) {
      throw new BadRequestException(parseBodyValidation.error);
    }

    const parsedBody = parseBodyValidation.data;
    
    return this.barangService.updateBarang(parseInt(id), parsedBody);
  }
  @Get(':id')
  findBarang(@Param('id') id: string) {
    return this.barangService.findBarang(parseInt(id));
  }
  @Delete(':id/delete')
  deleteBarang(@Param('id') id: string) {
    return this.barangService.deleteBarang(parseInt(id));
  }

  @Delete('delete-all')
  deleteAllBarang(@Body() data: DeleteBarangDto) {
    const parsedBody = deleteBarangSchemaValidaton.safeParse(data);
    if (!parsedBody.success) {
      throw new BadRequestException(parsedBody.error);
    }
    const parsedData = parsedBody.data;
    return this.barangService.deleteAllBarang(parsedData.id);
  }
}

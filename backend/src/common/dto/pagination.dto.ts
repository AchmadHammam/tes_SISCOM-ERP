import { z } from 'zod';
import { createZodDto } from 'nestjs-zod';

// schema validasi query param
export const PaginationSchema = z.object({
  page: z.preprocess(
    (val) => parseInt(z.string().parse(val), 10),
    z.number().int().min(1).default(1),
  ),
  limit: z.preprocess(
    (val) => parseInt(z.string().parse(val), 10),
    z.number().int().min(1).max(100).default(10),
  ),
});

export const PaginationFindSchema = PaginationSchema.extend({
  find: z.string().optional(),
});

// DTO untuk NestJS
export class PaginationDto extends createZodDto(PaginationSchema) {}
export class PaginationFindDto extends createZodDto(PaginationFindSchema) {}

import {
  IsString,
  IsNumber,
  IsOptional,
  IsUrl,
  IsUUID,
  IsArray,
  ValidateNested,
  MinLength,
  Min,
} from "class-validator";
import { Type } from "class-transformer";

class IngredienteDto {
  @IsUUID()
  id_producto!: string;

  @IsNumber()
  @Min(0)
  cantidad!: number;
}

class PasoDto {
  @IsNumber()
  @Min(1)
  orden!: number;

  @IsString()
  @MinLength(1)
  paso!: string;
}

export class CreateOrUpdateRecipeDto {
  @IsNumber()
  profit!: number;

  @IsString()
  @MinLength(4)
  nombre!: string;

  @IsNumber()
  porcionesTotales!: number;

  @IsOptional()
  @IsUrl()
  imagenURL?: string;

  @IsUUID()
  idUsuario!: string;

  @IsString()
  descripcion!: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => IngredienteDto)
  ingredientes!: IngredienteDto[];

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => PasoDto)
  pasos!: PasoDto[];
}

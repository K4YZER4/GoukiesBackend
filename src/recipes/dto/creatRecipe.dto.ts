import { IsString, MinLength, IsUrl, IsOptional, IsNumber, IsUUID } from "class-validator";

/*"id" UUID [pk]
  "profit" INT [not null]
  "nombre" VARCHAR(30) [not null]
  "porcionesTotales" INT [not null]
  "imagenURL" VARCHAR(300)
  "fechaCreacion" TIMESTAMP [not null, default: `NOW()`]
  "fechaModificacion" TIMESTAMP
  "idUsuario" UUID [not null]^*/
export class CreateRecipeDto {
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
}

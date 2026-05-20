import { IsString, MinLength, IsNumber, minLength, IsUUID } from "class-validator";
export class CreateIngredientDto {
  @IsNumber()
  id_ingrediente!: number;

  @IsNumber()
  id_marca!: number;

  @IsNumber()
  id_tipo!: number;

  @IsNumber()
  pzas!: number;

  @IsNumber()
  precio_medio!: number;

  @IsNumber()
  cantidad_inventario!: number;

  @IsNumber()
  cantidad_unitario!: number;

  @IsUUID()
  id_usuario!: string;

  @IsNumber()
  id_unidad!: number;
}

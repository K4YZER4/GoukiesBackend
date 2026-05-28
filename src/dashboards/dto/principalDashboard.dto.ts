import { IsUUID, IsNumber } from "class-validator";
export class PrincipalDashboardDto {
  @IsUUID()
  id_usuario!: string;
  @IsNumber()
  cantidad_ingredientes!: number;
  @IsNumber()
  cantidad_recetas!: number;
}

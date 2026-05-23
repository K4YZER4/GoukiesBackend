import { IsUUID } from "class-validator";
export class DeleteIngredientDto {
  @IsUUID()
  id!: string;
}

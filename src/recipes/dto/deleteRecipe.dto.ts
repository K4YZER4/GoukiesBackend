import { IsUUID } from "class-validator";

export class deleteRecipeDto {
  @IsUUID()
  id!: string;
}

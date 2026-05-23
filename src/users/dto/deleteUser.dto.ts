import { IsUUID } from "class-validator";
export class deleteUserDto {
  @IsUUID()
  id!: string;
}

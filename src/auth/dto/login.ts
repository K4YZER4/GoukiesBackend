import { IsString, MinLength } from "class-validator";

export class LoginDto {
  @MinLength(4)
  password!: string;

  @IsString()
  @MinLength(4)
  identificador!: string;
}

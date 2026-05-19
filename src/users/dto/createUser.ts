import { IsEmail, IsString, MinLength, isEmail } from "class-validator";

export class CreateUserDto {
  @MinLength(4)
  password!: string;

  @IsString()
  @MinLength(4)
  nombre!: string;

  @IsEmail()
  @IsString()
  @MinLength(9)
  correo_electronico!: string;

  @IsString()
  @MinLength(1)
  codigo_moneda!: string;
}

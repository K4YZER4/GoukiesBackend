import { Injectable, UnauthorizedException } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";
import { LoginDto } from "./dto/login";

@Injectable()
export class AuthService {
  constructor(private readonly prisma: PrismaService) {}

  async login(dto: LoginDto) {
    const esCorreo = dto.identificador.includes("@");
    const usuario = await this.prisma.db.usuario.findFirst({
      where: esCorreo ? { correo_electronico: dto.identificador } : { nombre: dto.identificador },
    });
    if (!usuario) {
      throw new UnauthorizedException("Usuario incorrecto");
    }

    if (usuario.contrasena_hash !== dto.password) {
      throw new UnauthorizedException("Contraseña incorrecta");
    }

    return usuario;
  }
}

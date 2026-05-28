import { Injectable, UnauthorizedException } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";
import { LoginDto } from "./dto/login";
import * as bcrypt from "bcrypt";
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

    // ↓ CAMBIAR ESTO: usar bcrypt.compare en lugar de !==
    const passwordValida = await bcrypt.compare(
      dto.password, // lo que el usuario escribió
      usuario.contrasena_hash // el hash guardado en BD
    );

    if (!passwordValida) {
      throw new UnauthorizedException("Contraseña incorrecta");
    }
    return { mensaje: "Login exitoso" };
  }
}

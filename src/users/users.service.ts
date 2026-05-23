import { PrismaService } from "../prisma/prisma.service";
import { Injectable, UnauthorizedException } from "@nestjs/common";
import { CreateUserDto } from "./dto/createUser";
import { deleteUserDto } from "./dto/deleteUser.dto";
@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}
  async delete(dto: deleteUserDto) {
    await this.prisma.db.usuario.delete({
      where: { id: dto.id },
    });
  }
  async create(dto: CreateUserDto) {
    const existeCorreo = await this.prisma.db.usuario.findFirst({
      where: { correo_electronico: dto.correo_electronico },
    });
    if (existeCorreo) {
      throw new UnauthorizedException("El correo electrónico ya está en uso");
    }
    const existeNombre = await this.prisma.db.usuario.findFirst({
      where: { nombre: dto.nombre },
    });
    if (existeNombre) {
      throw new UnauthorizedException("El nombre de usuario ya está en uso");
    }
    const usuario = await this.prisma.db.usuario.create({
      data: {
        nombre: dto.nombre,
        correo_electronico: dto.correo_electronico,
        contrasena_hash: dto.password,
        moneda: {
          // Nombre de la tabla
          connect: { codigo: dto.codigo_moneda }, // ← así se conecta una FK
        },
      },
    });
    return usuario;
  }
}

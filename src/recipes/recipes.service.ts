import { Injectable } from "@nestjs/common";
import { createRecipeDto } from "./dto/creatRecipe.dto";
import { PrismaService } from "../prisma/prisma.service";
import { Prisma } from "@prisma/client";
import { NotFoundException, ConflictException } from "@nestjs/common/exceptions";
import { deleteRecipeDto } from "./dto/deleteRecipe.dto";
@Injectable()
export class RecipesService {
  constructor(private readonly prisma: PrismaService) {}
  async delete(dto: deleteRecipeDto) {
    if (!dto.id) {
      throw new NotFoundException("Receta no encontrada");
    }
    await this.prisma.db.receta.delete({
      where: { id: dto.id },
    });
  }
  async selectAll() {
    return this.prisma.db.receta.findMany();
  }
  async create(dto: createRecipeDto) {
    try {
      const receta = await this.prisma.db.receta.create({
        data: {
          nombre: dto.nombre,
          profit: dto.profit,
          porciones_totales: dto.porcionesTotales,
          imagen_url: dto.imagenURL,
          fecha_modificacion: new Date(),
          descripcion: dto.descripcion,
          usuario: {
            connect: { id: dto.idUsuario },
          },
        },
      });
      return receta;
    } catch (e: any) {
      if (e instanceof Prisma.PrismaClientKnownRequestError) {
        if (e.code === "P2025") {
          const causa = (e.meta?.cause as string) ?? "";
          const modelo = causa.match(/'(\w+)' record/)?.[1] ?? "Relación";
          throw new NotFoundException(`${modelo} no encontrado`);
        }
        if (e.code === "P2002") {
          // Por si acaso hay un campo único duplicado
          const campo = (e.meta?.target as string[])?.join(", ") ?? "campo";
          throw new ConflictException(`El ${campo} ya existe`);
        }
      }
      throw e;
    }
  }
}

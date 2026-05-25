import { Injectable } from "@nestjs/common";
import { CreateOrUpdateRecipeDto } from "./dto/createOrUpedateRecipe.dto";
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
    const [recetas, pasos, ingredientes] = await Promise.all([
      this.prisma.db.receta.findMany(),
      this.prisma.db.vistaPasosPorReceta.findMany({ orderBy: { orden: "asc" } }),
      this.prisma.db.vistaProductoReceta.findMany(),
    ]);
    return recetas.map((receta) => ({
      ...receta,
      pasos: pasos.filter((p) => p.id_receta === receta.id),
      ingredientes: ingredientes.filter((i) => i.id_receta === receta.id),
    }));
  }
  async createOrUpdate(dto: CreateOrUpdateRecipeDto, id?: string) {
    return this.prisma.db.$transaction(async (tx) => {
      // 1. Crear o actualizar la receta
      const receta = id
        ? await tx.receta.update({
            where: { id },
            data: {
              nombre: dto.nombre,
              descripcion: dto.descripcion,
              profit: dto.profit,
              porciones_totales: dto.porcionesTotales,
              imagen_url: dto.imagenURL,
            },
          })
        : await tx.receta.create({
            data: {
              nombre: dto.nombre,
              descripcion: dto.descripcion,
              profit: dto.profit,
              porciones_totales: dto.porcionesTotales,
              imagen_url: dto.imagenURL,
              id_usuario: dto.idUsuario,
            },
          });

      // 2. Pasos — borrar los viejos y crear los nuevos
      await tx.recetaPaso.deleteMany({
        where: { id_receta: receta.id },
      });
      await tx.recetaPaso.createMany({
        data: dto.pasos.map((p) => ({
          id_receta: receta.id,
          orden: p.orden,
          paso: p.paso,
        })),
      });

      // 3. Ingredientes — borrar los viejos y crear los nuevos
      await tx.recetaProducto.deleteMany({
        where: { id_receta: receta.id },
      });
      await tx.recetaProducto.createMany({
        data: dto.ingredientes.map((i) => ({
          id_receta: receta.id,
          id_producto: i.id_producto,
          cantidad: i.cantidad,
        })),
      });

      return {
        message: id ? "Receta actualizada correctamente" : "Receta creada correctamente",
        id: receta.id,
      };
    });
  }
}

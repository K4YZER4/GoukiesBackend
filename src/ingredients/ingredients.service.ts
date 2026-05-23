import {
  Injectable,
  UnauthorizedException,
  NotFoundException,
  ConflictException,
} from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { PrismaService } from "../prisma/prisma.service";
import { CreateIngredientDto } from "./dto/createIngredient.dto";
import { DeleteIngredientDto } from "./dto/deleteIngredien.dto";
import { Logger } from "@nestjs/common";
import { deleteRecipeDto } from "../recipes/dto/deleteRecipe.dto";
@Injectable()
export class IngredientsService {
  constructor(private readonly prisma: PrismaService) {}
  private readonly logger = new Logger(IngredientsService.name);
  async delete(dto: DeleteIngredientDto) {
    await this.prisma.db.producto.delete({
      where: { id: dto.id },
    });
  }
  async selectAll() {
    return this.prisma.db.producto.findMany();
  }
  async create(dto: CreateIngredientDto) {
    try {
      const nuevoIngrediente = await this.prisma.db.producto.create({
        data: {
          pzas: dto.pzas,
          precio_medio: dto.precio_medio,
          cantidad_inventario: dto.cantidad_inventario,
          cantidad_unitario: dto.cantidad_unitario,
          ingrediente: {
            connect: { id: dto.id_ingrediente },
          },
          marca: {
            connect: { id: dto.id_marca },
          },
          tipo: {
            connect: { id: dto.id_tipo },
          },
          unidad: {
            connect: { id: dto.id_unidad },
          },
          usuario: {
            connect: { id: dto.id_usuario },
          },
        },
      });
      this.logger.log(`Ingrediente creado: ${JSON.stringify(nuevoIngrediente)}`);
      return nuevoIngrediente;
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

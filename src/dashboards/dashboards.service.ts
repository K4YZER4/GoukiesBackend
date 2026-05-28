import { Injectable } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";
import { PrincipalDashboardDto } from "./dto/principalDashboard.dto";
import { RawDashboardRow } from "../types/getPrincipalDashboard.types";
@Injectable()
export class DashboardsService {
  constructor(private readonly prisma: PrismaService) {}
  async getPrincipalDashboardData(dto: PrincipalDashboardDto) {
    const result = await this.prisma.db
      .$queryRaw<RawDashboardRow>`SELECT receta.get_dashboard_data(${dto.id_usuario}::uuid, ${dto.cantidad_ingredientes}, ${dto.cantidad_recetas})`; // Para debug, muestra la consulta SQL generada
    return result[0]?.get_dashboard_data || null; // Devuelve el JSON o null si no hay resultados
  }
}

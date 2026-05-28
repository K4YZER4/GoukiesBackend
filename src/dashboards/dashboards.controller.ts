import { Controller, Post, Body } from "@nestjs/common";
import { DashboardsService } from "./dashboards.service";
import { PrincipalDashboardDto } from "./dto/principalDashboard.dto";
@Controller("dashboards")
export class DashboardsController {
  constructor(private readonly dashboardsService: DashboardsService) {}
  @Post("principalDashboard")
  getPrincipalDashboardData(@Body() dto: PrincipalDashboardDto) {
    return this.dashboardsService.getPrincipalDashboardData(dto);
  }
}

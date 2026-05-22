import { Controller, Post, Body, Get } from "@nestjs/common";
import { IngredientsService } from "./ingredients.service";

@Controller("ingredients")
export class IngredientsController {
  constructor(private readonly ingredientsService: IngredientsService) {}

  @Post("create")
  create(@Body() dto: any) {
    return this.ingredientsService.create(dto);
  }

  @Get("obtain-all")
  selectAll() {
    return this.ingredientsService.selectAll();
  }
}

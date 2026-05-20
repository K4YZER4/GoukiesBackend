import { Controller, Post, Body } from "@nestjs/common";
import { IngredientsService } from "./ingredients.service";

@Controller("ingredients")
export class IngredientsController {
  constructor(private readonly ingredientsService: IngredientsService) {}

  @Post("create")
  create(@Body() dto: any) {
    return this.ingredientsService.create(dto);
  }
}

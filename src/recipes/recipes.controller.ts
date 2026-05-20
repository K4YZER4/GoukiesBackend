import { Controller, Post, Body } from "@nestjs/common";
import { createRecipeDto } from "./dto/creatRecipe.dto";
import { RecipesService } from "./recipes.service";
@Controller("recipes")
export class RecipesController {
  constructor(private readonly RecipesService: RecipesService) {}
  @Post("create")
  create(@Body() dto: createRecipeDto) {
    return this.RecipesService.create(dto);
  }
}

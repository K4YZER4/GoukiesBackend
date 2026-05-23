import { Controller, Post, Body, Get } from "@nestjs/common";
import { createRecipeDto } from "./dto/creatRecipe.dto";
import { RecipesService } from "./recipes.service";
import { deleteRecipeDto } from "./dto/deleteRecipe.dto";
@Controller("recipes")
export class RecipesController {
  constructor(private readonly RecipesService: RecipesService) {}
  @Post("create")
  create(@Body() dto: createRecipeDto) {
    return this.RecipesService.create(dto);
  }

  @Get("obtain-all")
  selectAll() {
    return this.RecipesService.selectAll();
  }

  @Post("delete")
  delete(@Body() dto: deleteRecipeDto) {
    return this.RecipesService.delete(dto);
  }
}

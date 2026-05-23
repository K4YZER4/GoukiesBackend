import { Controller, Post, Body, Get, Param, Patch, ParseUUIDPipe } from "@nestjs/common";
import { CreateRecipeDto } from "./dto/creatRecipe.dto";
import { RecipesService } from "./recipes.service";
import { deleteRecipeDto } from "./dto/deleteRecipe.dto";
import { UpdateRecipeDto } from "./dto/updateRecipe.dto";
@Controller("recipes")
export class RecipesController {
  constructor(private readonly RecipesService: RecipesService) {}
  @Post("create")
  create(@Body() dto: CreateRecipeDto) {
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

  @Patch("update/:id")
  update(@Param("id", ParseUUIDPipe) id: string, @Body() dto: UpdateRecipeDto) {
    return this.RecipesService.update(id, dto);
  }
}

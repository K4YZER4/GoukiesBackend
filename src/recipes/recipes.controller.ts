import { Controller, Post, Body, Get, Param, Patch, ParseUUIDPipe } from "@nestjs/common";
import { CreateOrUpdateRecipeDto } from "./dto/createOrUpedateRecipe.dto";
import { RecipesService } from "./recipes.service";
import { deleteRecipeDto } from "./dto/deleteRecipe.dto";
@Controller("recipes")
export class RecipesController {
  constructor(private readonly RecipesService: RecipesService) {}

  @Get("obtain-all")
  selectAll() {
    return this.RecipesService.selectAll();
  }

  @Post("delete")
  delete(@Body() dto: deleteRecipeDto) {
    return this.RecipesService.delete(dto);
  }
  @Post("create")
  create(@Body() dto: CreateOrUpdateRecipeDto) {
    return this.RecipesService.createOrUpdate(dto);
  }

  @Patch("update/:id")
  update(
    @Param("id", ParseUUIDPipe) id: string,
    @Body() dto: CreateOrUpdateRecipeDto // puedes seguir usando CreateOrUpdateRecipeDto si prefieres
  ) {
    return this.RecipesService.createOrUpdate(dto, id);
  }
}

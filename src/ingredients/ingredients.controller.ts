import { Controller, Post, Body, Get, Patch, ParseUUIDPipe, Param } from "@nestjs/common";
import { IngredientsService } from "./ingredients.service";
import { DeleteIngredientDto } from "./dto/deleteIngredien.dto";
import { CreateIngredientDto } from "./dto/createIngredient.dto";
import { UpdateIngredientDto } from "./dto/updateIngredient.dto";
@Controller("ingredients")
export class IngredientsController {
  constructor(private readonly ingredientsService: IngredientsService) {}

  @Post("create")
  create(@Body() dto: CreateIngredientDto) {
    return this.ingredientsService.create(dto);
  }

  @Get("obtain-all")
  selectAll() {
    return this.ingredientsService.selectAll();
  }
  @Post("delete")
  delete(@Body() dto: DeleteIngredientDto) {
    return this.ingredientsService.delete(dto);
  }
  @Patch("update/:id")
  update(@Param("id", ParseUUIDPipe) id: string, @Body() dto: UpdateIngredientDto) {
    return this.ingredientsService.update(id, dto);
  }
}

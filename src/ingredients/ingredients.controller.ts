import { Controller, Post, Body, Get, Patch, ParseUUIDPipe, Param } from "@nestjs/common";
import { IngredientsService } from "./ingredients.service";
import { DeleteIngredientDto } from "./dto/deleteIngredien.dto";
import { CreateIngredientDto } from "./dto/createIngredient.dto";
import { UpdateIngredientDto } from "./dto/updateIngredient.dto";
@Controller("ingredients")
export class IngredientsController {
  constructor(private readonly ingredientsService: IngredientsService) {}

  @Post("createOrUpdate")
  create(@Body() dto: CreateIngredientDto) {
    return this.ingredientsService.createOrUpdate(dto);
  }

  @Get("obtain-all")
  selectAll() {
    return this.ingredientsService.selectAll();
  }
  @Post("delete")
  delete(@Body() dto: DeleteIngredientDto) {
    return this.ingredientsService.delete(dto);
  }
  @Patch("createOrUpdate/:id_producto")
  update(@Param("id_producto", ParseUUIDPipe) id: string, @Body() dto: CreateIngredientDto) {
    return this.ingredientsService.createOrUpdate(dto, id);
  }
}

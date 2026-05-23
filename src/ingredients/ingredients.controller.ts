import { Controller, Post, Body, Get } from "@nestjs/common";
import { IngredientsService } from "./ingredients.service";
import { DeleteIngredientDto } from "./dto/deleteIngredien.dto";
import { CreateIngredientDto } from "./dto/createIngredient.dto";
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
}

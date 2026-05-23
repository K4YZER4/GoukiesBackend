import { PartialType } from "@nestjs/mapped-types";
import { CreateIngredientDto } from "./createIngredient.dto";
export class UpdateIngredientDto extends PartialType(CreateIngredientDto) {}

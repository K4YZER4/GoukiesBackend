import { PartialType } from "@nestjs/mapped-types";
import { CreateRecipeDto } from "./creatRecipe.dto";
export class UpdateRecipeDto extends PartialType(CreateRecipeDto) {}

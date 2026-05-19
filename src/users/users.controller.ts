import { Post, Body, Controller } from "@nestjs/common";
import { CreateUserDto } from "./dto/createUser";
import { UsersService } from "./users.service";
@Controller("users")
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post("create")
  create(@Body() dto: CreateUserDto) {
    return this.usersService.create(dto);
  }
}

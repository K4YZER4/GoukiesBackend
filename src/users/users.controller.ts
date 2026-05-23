import { Post, Body, Controller } from "@nestjs/common";
import { CreateUserDto } from "./dto/createUser";
import { UsersService } from "./users.service";
import { deleteUserDto } from "./dto/deleteUser.dto";
@Controller("users")
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post("create")
  create(@Body() dto: CreateUserDto) {
    return this.usersService.create(dto);
  }

  @Post("delete")
  delete(@Body() dto: deleteUserDto) {
    return this.usersService.delete(dto);
  }
}

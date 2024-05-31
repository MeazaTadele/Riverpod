import { Request } from 'express';
import { UpdateUserDto } from './dto/user_update_dto';
import { UserDocument } from './schemas/user.interface';
import { UserService } from './user.service';
export declare class UserController {
    private userService;
    constructor(userService: UserService);
    getProfile(req: Request): Promise<UserDocument>;
    updateUser(id: string, updateData: UpdateUserDto): Promise<UserDocument>;
}

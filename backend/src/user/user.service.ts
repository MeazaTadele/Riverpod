import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import * as bcrypt from 'bcryptjs';
import { Model } from 'mongoose';
import { UserDocument } from './schemas/user.interface';


@Injectable()
export class UserService {
  constructor(@InjectModel('User') private userModel: Model<UserDocument>) {}

  
  async updateUser(userId: string, updateData: Partial<UserDocument>): Promise<UserDocument> {
    console.log("Received update data:", updateData);

    if (updateData.password) {
      console.log('Original password:', updateData.password);  // Log the original password
      updateData.password = await bcrypt.hash(updateData.password, 10);
      console.log('Hashed password:', updateData.password);  // Log the hashed password
    }

    const updatedUser = await this.userModel.findByIdAndUpdate(userId, updateData, { new: true }).exec();
    if (!updatedUser) {
      throw new NotFoundException('User not found');
    }
    return updatedUser;
  }
  async getUserById(userId: string): Promise<UserDocument> {
    const user = await this.userModel.findById(userId).exec();
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }
}

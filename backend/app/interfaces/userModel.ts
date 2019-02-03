import { Model } from 'mongoose';
import { IUser } from './user';

export interface IUserModel extends Model<IUser> {
    // add any static user methods
    hashPassword(password: string): Promise<string>;
    authenticate(email: string, password: string): Promise<IUser>;
}
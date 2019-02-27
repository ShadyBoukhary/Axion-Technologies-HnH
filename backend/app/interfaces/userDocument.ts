import { Document } from 'mongoose';
import { User } from './non_modals/user';

export interface IUserDocument extends Document, User {
    _id: string;
}
import { Document} from 'mongoose';

export interface IUserDocument extends Document {
    email: string;
    password: string;
    _id: string;
    firstName: string;
    lastName: string;
}
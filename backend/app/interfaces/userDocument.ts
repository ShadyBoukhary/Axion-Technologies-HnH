import { Document} from 'mongoose';

export interface IUserDocument extends Document {
    email: string;
    password: string;
    userId: string;
    firstName: string;
    lastName: string;
}
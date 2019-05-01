import { Model } from 'mongoose';
import { IPasswordReset } from './resetPasswordDocument';

export interface IPasswordResetModel extends Model<IPasswordReset> {
    // add any static event methods
}
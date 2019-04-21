import { Document } from 'mongoose';
import { PasswordReset } from '../non_modals/passwordReset';

export interface IPasswordReset extends Document, PasswordReset {
}
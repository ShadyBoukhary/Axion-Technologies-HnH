'use strict';
import { Schema, model } from 'mongoose';
import { IPasswordResetModel } from '../interfaces/passwordReset/passwordResetModel';
import { IPasswordReset } from '../interfaces/passwordReset/resetPasswordDocument';
import { PasswordReset } from '../interfaces/non_modals/passwordReset';

export const PasswordResetSchema = new Schema<PasswordReset>({
    uid: { type: String, required: true },
    email: { type: String, required: true },
    token: { type: String, required: true, default: Math.floor(Date.now() / 1000).toString()}
}, {versionKey: false});

PasswordResetSchema.index({uid: 1}, {unique: true});

export const PassReset: IPasswordResetModel = model<IPasswordReset, IPasswordResetModel>('PasswordReset', PasswordResetSchema);
export default PassReset;
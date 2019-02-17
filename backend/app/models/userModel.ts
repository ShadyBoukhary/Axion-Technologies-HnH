'use strict';
import { Document, Schema, model } from 'mongoose';
import { IUserDocument } from '../interfaces/userDocument';
import bcrypt from 'bcrypt';
import { IUserModel } from '../interfaces/userModel';
import { IUser } from '../interfaces/user';

export const UserSchema = new Schema({
    email: {
        type: String,
        unique: true,
        required: true,
        trim: true
    },
    password: {
        type: String,
        required: true
    },

    firstName: String,
    lastName: String,
});

UserSchema.pre<IUserDocument>('save', async function (next) {

    try {
        let hash = await User.hashPassword(this.password);
        this.password = hash;
        next();
    } catch (error) {
        next(error);
    }
});

//authenticate input against database
/* eslint-disable */

UserSchema.static('hashPassword', async (password: string) => {
    try {
        let hash = await bcrypt.hash(password, 10);
        return hash;
    } catch (error) {
        console.error(error);
        throw error;
    }
});

UserSchema.methods.comparePassword = async function (password: string): Promise<boolean> {
    try {
        let match: boolean = await bcrypt.compare(password, this.password)
        return match;
    } catch (error) {
        console.log(error);
        throw error;
    }
}

UserSchema.static('authenticate', async (email: string, password: string) => {

    try {
        let user = await User.findOne({email: email});
        if (user == null) throw "No user with this email is registerd on our system."
        let match = await user.comparePassword(password);
        if (!match) throw "The password provided is incorrect.";
        return user;
    } catch (error) {
        console.log(error);
        throw error;
    }
});


export const User: IUserModel = model<IUser, IUserModel>('User', UserSchema);

export default User;
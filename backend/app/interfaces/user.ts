import { IUserDocument } from "./userDocument";

export interface IUser extends IUserDocument {
    // add any methods
    comparePassword(password: string): Promise<boolean>;
}
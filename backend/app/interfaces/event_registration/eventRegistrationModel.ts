import { Model } from 'mongoose';
import { IEventRegistration } from './eventRegistration';

export interface IEventRegistrationModel extends Model<IEventRegistration> {
    // add any static event methods
}
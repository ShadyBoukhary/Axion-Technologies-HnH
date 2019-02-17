import { Model } from 'mongoose';
import { IEvent } from './event';

export interface IEventModel extends Model<IEvent> {
    // add any static event methods
}
import { Document } from 'mongoose';
import { Event } from '../non_modals/event';

export interface IEventDocument extends Document, Event {
    _id: string;
}
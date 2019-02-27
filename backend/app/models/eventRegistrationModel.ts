'use strict';
import { Schema, model } from 'mongoose';
import { IEventRegistrationModel } from '../interfaces/event_registration/eventRegistrationModel';
import { IEventRegistration } from '../interfaces/event_registration/eventRegistration';
import { UserSchema } from './userModel';
import { EventSchema } from './eventModel';

export const EventRegistrationSchema = new Schema({
    user: { type: UserSchema, required: true },
    event: [{ type: EventSchema, required: true }],
}, {versionKey: false});

export const EventRegistration: IEventRegistrationModel = model<IEventRegistration, IEventRegistrationModel>('EventRegistrationSchema', EventRegistrationSchema);
export default EventRegistration;
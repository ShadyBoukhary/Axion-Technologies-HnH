'use strict';
import { Schema, model } from 'mongoose';
import { IEventRegistrationModel } from '../interfaces/event_registration/eventRegistrationModel';
import { IEventRegistration } from '../interfaces/event_registration/eventRegistration';


var EventRegistrationSchema = new Schema({
    uid: { type: String, required: true },
    eventId: { type: String, required: true },
    timestamp: {type: String, required: true}
}, {versionKey: false});

EventRegistrationSchema.index({uid: 1, eventId: 1}, {unique: true});
EventRegistrationSchema.on('index', (e) => {
    console.log(e);
});

export const EventRegistration: IEventRegistrationModel = model<IEventRegistration, IEventRegistrationModel>('EventRegistration', EventRegistrationSchema);
EventRegistration.createIndexes();
export default EventRegistration;
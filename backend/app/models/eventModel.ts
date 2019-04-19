'use strict';
import { Schema, model } from 'mongoose';
import { IEventModel } from '../interfaces/event/eventModel';
import { IEvent } from '../interfaces/event/event';
import { Location } from '../interfaces/non_modals/location';
import { Coordinates } from '../interfaces/non_modals/coordinates';

const LocationScehma = new Schema<Location>({
    lat: {type: String, required: true},
    lon: {type: String, required: true},
    timestamp: {type: String, required: true}
}, {_id: false});

const CoordinatesScheme = new Schema<Coordinates>({
    lat: {type: String, required: true},
    lon: {type: String, required: true},
}, {_id: false});

export const EventSchema = new Schema({
    name: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true
    },
    location: {
        type: LocationScehma,
        required: true
    },
    route: [{type: CoordinatesScheme, required: true}],
    stops: [{type: CoordinatesScheme, required: true}],
    imageUrl: {type: String, required: true},
    isFeatured: {type: Boolean, required: true}

}, {versionKey: false});

export const Event: IEventModel = model<IEvent, IEventModel>('Event', EventSchema);

export default Event;
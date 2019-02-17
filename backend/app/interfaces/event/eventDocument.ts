import { Document } from 'mongoose';
import { Location } from '../non_modals/location';
import { Coordinates } from '../non_modals/coordinates';

export interface IEventDocument extends Document {
    _id: string;
    name: string;
    description: string;
    location: Location;
    route: Coordinates[];
}
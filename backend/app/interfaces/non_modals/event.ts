import { Location } from '../non_modals/location';
import { Coordinates } from '../non_modals/coordinates';

export interface Event {
    _id: string;
    name: string;
    description: string;
    location: Location;
    route: Coordinates[];
    imageUrl: string;
    isFeatured: Boolean;
}
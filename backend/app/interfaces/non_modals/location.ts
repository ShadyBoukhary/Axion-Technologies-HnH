import { Coordinates } from './coordinates';

export interface Location extends Coordinates {
    timestamp: string;
}
import { Model } from 'mongoose';
import { ISponsor } from './sponsor';

export interface ISponsorModel extends Model<ISponsor> {
    // add any static event methods
}
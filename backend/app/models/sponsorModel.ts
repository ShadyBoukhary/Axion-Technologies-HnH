'use strict';
import { Schema, model } from 'mongoose';
import { ISponsor } from '../interfaces/sponsor/sponsor';
import { ISponsorModel } from '../interfaces/sponsor/sponsorModel';


export const SponsorSchema = new Schema({
    name: { type: String, required: true },
    website: { type: String, required: true },
    imageUrl: {type: String, required: true},
    year: {type: String, required: true}
}, {versionKey: false});

SponsorSchema.index({website: 1}, {unique: true});

export const Sponsor: ISponsorModel = model<ISponsor, ISponsorModel>('Sponsor', SponsorSchema);
export default Sponsor;
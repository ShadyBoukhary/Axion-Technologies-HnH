'use strict';
import { Schema, model } from 'mongoose';
import { IHHHModel } from '../interfaces/hhh/hhhModel';
import { IHHH } from '../interfaces/hhh/hhh';


export const HHHSchema = new Schema({
    id: { type: String, required: true },
    description: { type: String, required: true },
    mailingAddress: { type: String, required: true },
    timestamp: {type: String, required: true},
    sponsors: [{type: String, required: true}, {_id: false}],
    events: [{type: String, required: true}, {_id: false}],

}, {versionKey: false});

HHHSchema.index({id: 1}, {unique: true});

export const HHH: IHHHModel = model<IHHH, IHHHModel>('HHH', HHHSchema);
export default HHH;
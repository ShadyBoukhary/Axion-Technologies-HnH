import { Document } from 'mongoose';
import { HHH } from '../non_modals/hhh';

export interface IHHHDocument extends Document, HHH {
    id: string;
}
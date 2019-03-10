import { Document } from 'mongoose';
import { Sponsor } from '../non_modals/sponsor';

export interface ISponsorDocument extends Document, Sponsor {}
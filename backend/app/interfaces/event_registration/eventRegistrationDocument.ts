import { Document } from 'mongoose';
import { EventRegistration } from '../non_modals/eventRegistration';

export interface IEventRegistrationDocument extends Document, EventRegistration {
}
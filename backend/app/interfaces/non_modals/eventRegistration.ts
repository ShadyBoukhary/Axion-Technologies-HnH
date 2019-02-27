import { User } from "./user";
import { Event } from "./event";

export interface EventRegistration {
    _id: string;
    user: User;
    event: Event;
}
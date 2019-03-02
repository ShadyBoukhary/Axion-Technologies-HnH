'use strict';
import { model } from 'mongoose';
import { Request, Response } from 'express-serve-static-core';
import { NextFunction } from 'connect';
import { IEvent } from '../interfaces/event/event';
import { IEventModel } from '../interfaces/event/eventModel';
import { EventSchema } from '../models/eventModel';
import { CREATE_EVENTS_PASS } from '../config';
import { IEventRegistration } from '../interfaces/event_registration/eventRegistration';
import { IEventRegistrationModel } from '../interfaces/event_registration/eventRegistrationModel';
import { EventRegistrationSchema } from '../models/eventRegistrationModel';
import * as eg from '../interfaces/non_modals/eventRegistration';
import { ObjectID } from 'bson';

const Event = model<IEvent, IEventModel>('Event', EventSchema);
const EventRegistration = model<IEventRegistration, IEventRegistrationModel>('EventRegistration', EventRegistrationSchema);


/**
 * GET Route: getEvents
 * Retrieves all Events for HnH or Events for a specific user
 *
 * @export async getEvents
 * @param {Request} req
 * @param {Response} res
 */
export async function getEvents(req: Request, res: Response, next: NextFunction) {
    try {
        // get uid from request query
        let uid = req.query.uid;
        console.log(uid);
        // get all events or user events depending on whether a uid was provided
        let events: IEvent[] = uid ? await getUserEvents(uid) : await Event.find({}).exec();

        // convert events to events with right variable names
        let eventsToDump = events.map((event) => {
            console.log(JSON.stringify(event.route));
            return {
                name: event.name,
                description: event.description,
                location: event.location,
                route: event.route,
                id: event.id
            };
        });

        res.status(200);
        res.json(eventsToDump);

    } catch (error) {
        res.status(400);
        res.statusMessage = error;
        res.send({
            'status': 400,
            'message': error.message,
            'statusText': 'Bad Request'
        });
        return next(error);
    }
}


/**
 * GET Route: Get an event by its id
 * If no Event was found, 400 is sent.
 * @export
 * @param {Request} req
 * @param {Response} res
 * @param {NextFunction} next
 * @returns
 */
export async function getEvent(req: Request, res: Response, next: NextFunction) {
    try {
        // get all events
        let uid = req.params.eventId;
        // if the uid is not a valid mongo id, throw error
        if (!uid.match(/^[0-9a-fA-F]{24}$/)) { throw new Error('Invalid Event Id.'); }
        
        // retrieve Events
        let event: IEvent | null = await Event.findById(uid).exec();

        // if there are no events, return 400 for bad eventId
        if (event === null) {
            res.status(400);
            res.statusMessage = 'No event was found.';
            res.send({
                'status': 400,
                'message': res.statusMessage,
                'statusText': 'Bad Request'
            });

        // if found
        } else {
            // convert event to event with right variable names
            let eventToDump: any = event;
            eventToDump.id = event._id;
            delete eventToDump._id;
            console.log(eventToDump);
            res.status(200);
            res.json(eventToDump);
        }

    } catch (error) {
        res.status(400);
        res.statusMessage = error;
        res.send({
            'status': 400,
            'message': error.message,
            'statusText': 'Bad Request'
        });
        return next(error);
    }
}


/**
 * POST Route: Creates hard-coded events and stores in database.
 * @export async createEvents
 * @param {Request} req
 * @param {Response} res
 * @param {NextFunction} next
 * @returns
 */
export async function createEvents(req: Request, res: Response) {

    // check for the password
    if (req.query.pass !== CREATE_EVENTS_PASS) {
        console.log(req.query.pass);
        res.sendStatus(403);
    } else {
        let events = [];

        // create events
        let event1 = {
            _id: '5c68d750cf2095b99753c693',
            name: 'Lorem Ipsum',
            description: 'Lorem Ipsum dolor sir.',
            location: {lat: '352523525', lon: '2423523525', timestamp: (Date.now() / 1000).toString()},
            route: [{lat: '234234234', lon: '4234234243'}]
        };

        let event2 = {
            _id: '5a68d750cf1095b92753c696',
            name: 'Lorem Ipsum',
            description: 'Lorem Ipsum dolor sir.',
            location: {lat: '35251223525', lon: '24234321523525', timestamp: (Date.now() / 1000).toString()},
            route: [{lat: '2342321214234', lon: '4234224334243'}]
        };

        let event3 = {
            _id: '5a68d750cf1095b92753c695',
            name: 'Lorem Ipsum',
            description: 'Lorem Ipsum dolor sir.',
            location: {lat: '352522343525', lon: '2423234523525', timestamp: (Date.now() / 1000).toString()},
            route: [{lat: '23423423234', lon: '423423124243'}]
        };

        events.push(event1);
        events.push(event2);
        events.push(event3);

        // save events to mongodb
        events.forEach(async (event) => {
            try {
                let eventModel = new Event(event);
                await eventModel.save();
            } catch (error) {
                console.log(error);
                if (error.code === 11000) {
                    console.log('Event already exists.');
                } else {
                    res.status(400);
                    res.send(error);
                }
            }
        }); // end foreach
        res.sendStatus(200);
    }


}

async function getUserEvents(uid: string): Promise<IEvent[]> {

    try {
        let eventRegistrations: eg.EventRegistration[] = await EventRegistration.find({uid: uid}).exec();
        if (eventRegistrations.length < 1) {
            return [];
        } else {
            let ids = eventRegistrations.map((evg) => new ObjectID(evg.eventId));
            let events: IEvent[] = await Event.find({_id: {$in: ids}});
            console.log(JSON.stringify(events));
            return events;
        }
    } catch (error) {
        throw error;
    }
}
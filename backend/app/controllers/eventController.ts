'use strict';
import { Request, Response } from 'express-serve-static-core';
import { NextFunction } from 'connect';
import { IEvent } from '../interfaces/event/event';
import { Event } from '../models/eventModel';
import { CREATE_EVENTS_PASS } from '../config';
import { EventRegistration } from '../models/eventRegistrationModel';
import * as eg from '../interfaces/non_modals/eventRegistration';
import { ObjectID } from 'bson';
import { EVENTS } from '../data/events';
import HHH from '../models/hhhModel';
import { getCurrentYear } from '../utils/utils';
import * as hhhinterface from '../interfaces/non_modals/hhh';



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
        let year = req.query.year;
        if (!year) year = getCurrentYear();
        console.log(uid);
        // get all events or user events depending on whether a uid was provided
        let events: IEvent[] = uid ? await getUserEvents(uid) : await getEventsByYear(year);

        // convert events to events with right variable names
        let eventsToDump = events.map((event) => {
            console.log(JSON.stringify(event.route));
            return {
                name: event.name,
                description: event.description,
                location: event.location,
                route: event.route,
                id: event.id,
                imageUrl: event.imageUrl,
                isFeatured: event.isFeatured
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

        // save events to mongodb
        EVENTS.forEach(async (event) => {
            try {
                let eventModel = new Event(event);
                await eventModel.save();
            } catch (error) {
                console.log(error);
                if (error.code === 11000) {
                    console.log('Event already exists, updating.');
                    await Event.updateOne({_id: event._id}, event).exec();
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
        // get event registration for a particular user
        let eventRegistrations: eg.EventRegistration[] = await EventRegistration.find({ uid: uid }).exec();
        if (eventRegistrations.length < 1) {
            return [];
        } else {
            // get all the events in current year
            let currentYearIds = (await HHH.findOne({ id: getCurrentYear() }).exec() as hhhinterface.HHH).events;

            // convert event registrations to event object ids
            let ids = eventRegistrations.map((evg) => new ObjectID(evg.eventId));

            // query using common ids between current events and registered events
            let events: IEvent[] = await Event.find({
                _id: {
                    $in: ids.filter(value => currentYearIds.includes(value.toHexString()))
                }
            });

            return events;
        }
    } catch (error) {
        throw error;
    }
}

async function getEventsByYear(year: string) {
    try {

        //get all the events in a year
        let ids = (await HHH.findOne({ id: year }).exec() as hhhinterface.HHH).events;

        // query using that years ids
        let events: IEvent[] = await Event.find({
            _id: {
                $in: ids
            }
        });

        return events;
    } catch (error) {
        throw error;
    }
}




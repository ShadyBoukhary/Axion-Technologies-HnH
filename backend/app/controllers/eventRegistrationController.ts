'use strict';
import { SECRET_KEY } from '../config';
import { Document, model } from 'mongoose';
import { Request, Response } from 'express-serve-static-core';
import { NextFunction } from 'connect';
import { IEventRegistration } from '../interfaces/event_registration/eventRegistration';
import { IEventRegistrationModel } from '../interfaces/event_registration/eventRegistrationModel';
import { EventRegistrationSchema } from '../models/eventRegistrationModel';
import * as eg from '../interfaces/non_modals/eventRegistration';



const EventRegistration = model<IEventRegistration, IEventRegistrationModel>('EventRegistration', EventRegistrationSchema);

/**
 * POST ROUTE - Creates an EventRegistration document
 * Represents an association relationship between a `User` and an `Event`
 * 
 * @export createEventRegistration
 * @param {Request} req
 * @param {Response} res
 * @param {NextFunction} next
 * @returns
 */
export function createEventRegistration(req: Request, res: Response, next: NextFunction) {
    console.log(req.body);

    if (!req.body.user || !req.body.event) {
        res.status(400).send({
            'status': '400',
            'message': 'Missing Fields',
            'statusText': 'Bad Request'
        });
        return next(new Error('Missing Fields'));
    }

    let eventRegistration = new EventRegistration(req.body);
    eventRegistration.save((err, eventReg) => {
        if (err) {
            if (err.code === 11000) {
                res.status(400).send({
                    'status': '400',
                    'message': 'Already registered to event.',
                    'statusText': 'Bad Request'
                });
            }

            return next(err);

        }
        res.status(200);
        res.send({
            id: eventReg._id,
            user: eventReg.user,
            event: eventReg.event,
        });
    });
}


/**
 * GET ROUTE - Gets all `EventRegistration`s by `User._id`
 *
 * @export
 * @param {Request} req
 * @param {Response} res
 * @param {NextFunction} next
 * @returns
 */
export async function getEventRegistrationsByUser(req: Request, res: Response, next: NextFunction) {


    try {
        // get uid from request query
        let uid = req.query.uid;
        if (!uid) {
            throw Error('User ID was not provided.');
        }

        let eventRegistrations: eg.EventRegistration[] = await EventRegistration.find({"user._id": uid }).exec();
        if (eventRegistrations.length < 1) {
            res.status(200).send([]);
        } else {
            let evgs = eventRegistrations.map((eg) => {
                let evg: any = eg;
                evg.id = eg._id;
                delete evg._id;
                return evg;
            });
            res.status(200).json(evgs);
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
 * DELETE REQUEST - Deletes an `EventRegistration` given its `_id`
 *
 * @export
 * @param {Request} req
 * @param {Response} res
 * @param {NextFunction} next
 * @returns
 */
export async function deleteEventRegistration(req: Request, res: Response, next: NextFunction) {
    try {
        let id = req.body.id;
        if (!id)
            throw Error('EventRegistration ID not provided');
        await EventRegistration.findByIdAndRemove(id).exec();
        res.sendStatus(200);
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
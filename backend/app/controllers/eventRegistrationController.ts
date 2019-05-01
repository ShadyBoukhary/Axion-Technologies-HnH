'use strict';

import { Request, Response } from 'express-serve-static-core';
import { NextFunction } from 'connect';
import { EventRegistration } from '../models/eventRegistrationModel';
import * as eg from '../interfaces/non_modals/eventRegistration';

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
export async function createEventRegistration(req: Request, res: Response, next: NextFunction) {
    console.log(req.body);

    if (!req.body.uid || !req.body.eventId || !req.body.timestamp) {
        res.status(400).send({
            'status': '400',
            'message': 'Missing Fields',
            'statusText': 'Bad Request'
        });
        return next(new Error('Missing Fields'));
    }
    let eventRegistration = new EventRegistration(req.body);
    console.log(JSON.stringify(eventRegistration));
    eventRegistration.save((err, eventReg) => {
        if (err) {
            let message = err.message;
            if (err.code === 11000) {
                message = 'Already registered to event.';
            }
            res.status(400).send({
                'status': '400',
                'message': message,
                'statusText': 'Bad Request'
            });
        } else {
            res.status(200);
            res.send({
                uid: eventReg.uid,
                event: eventReg.eventId,
                timestamp: eventReg.timestamp
            });

        }
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

        let eventRegistrations: eg.EventRegistration[] = await EventRegistration.find({ uid: uid }, '-_id').exec();
        if (eventRegistrations.length < 1) {
            res.status(200).send([]);
        } else {
            res.status(200).json(eventRegistrations);
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
        console.log(req.query);

        let uid = req.query.uid;
        let eventId = req.query.eventId;
        if (!uid || !eventId)
            throw Error('EventId or uid was not provided');
        await EventRegistration.findOneAndRemove({ uid: uid, eventId: eventId }).exec();
        res.status(200).send({
            'status': 200,
            'message': 'OK',
            'statusText': 'OK'
        });;
    } catch (error) {
        console.log(error.message);
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
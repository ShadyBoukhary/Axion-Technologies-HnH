'use strict';
import { Request, Response } from 'express-serve-static-core';
import { NextFunction } from 'connect';
import { IEvent } from '../interfaces/event/event';
import Event, { EventSchema } from '../models/eventModel';
import { CREATE_EVENTS_PASS } from '../config';
import * as eg from '../interfaces/non_modals/eventRegistration';
import { ObjectID } from 'bson';
import { EVENTS } from '../data/events';
import HHH from '../models/hhhModel';
import { getCurrentYear } from '../utils/utils';
import * as hhhinterface from '../interfaces/non_modals/hhh';
import * as interfaces from '../interfaces/non_modals/sponsor';
import Sponsor from '../models/sponsorModel';
import { SPONSORS } from '../data/sponsors';


/**
 * GET Route: getSponsors
 * Retrieves all Sponsors for a specific year
 *
 * @export async getSponsors
 * @param {Request} req
 * @param {Response} res
 */
export async function getSponsorsByYear(req: Request, res: Response, next: NextFunction) {
    try {
        let year = req.query.year;
        if (!year) year = getCurrentYear();

        // get all events or user events depending on whether a uid was provided
        let sponsors: interfaces.Sponsor[] = await Sponsor.find({year: year}).exec();

        res.status(200);
        res.json(sponsors);

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
export async function createSponsors(req: Request, res: Response) {

    // check for the password
    if (req.query.pass !== CREATE_EVENTS_PASS) {
        console.log(req.query.pass);
        res.sendStatus(403);
    } else {

        // save events to mongodb
        SPONSORS.forEach(async (sponsor: interfaces.Sponsor) => {
            try {
                let sponsorModel = new Sponsor(sponsor);
                await sponsorModel.save();
            } catch (error) {
                console.log(error);
                if (error.code === 11000) {
                    console.log('Sponsor already exists.');
                    await Sponsor.updateOne({website: sponsor.website}, sponsor).exec();
                } else {
                    res.status(400);
                    res.send(error);
                }
            }
        }); // end foreach
        res.sendStatus(200);
    }
}




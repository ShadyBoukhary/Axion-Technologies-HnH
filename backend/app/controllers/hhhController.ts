'use strict';

import { model } from 'mongoose';
import { IHHH } from "../interfaces/hhh/hhh";
import { IHHHModel } from "../interfaces/hhh/hhhModel";
import { HHHSchema } from "../models/hhhModel";
import { Request, Response } from 'express-serve-static-core';
import { NextFunction } from 'connect';
import * as hhhInterface from '../interfaces/non_modals/hhh';
import { CREATE_EVENTS_PASS } from '../config';
import { HHHs } from '../data/hhh';

const HHH = model<IHHH, IHHHModel>('HHH', HHHSchema);

export async function getHHHs(req: Request, res: Response, next: NextFunction) {
    try {

        // get all HHHs
        let hhhs: IHHH[] = await HHH.find({}).exec();

        // convert HHHs to HHHs with right variable names
        let hhhsToDump = hhhs.map((hhh) => {
            return {
                id: hhh.id,
                description: hhh.description,
                mailingAddress: hhh.mailingAddress,
                timestamp: hhh.timestamp,
                sponsors: hhh.sponsors,
                events: hhh.events
            };
        });

        res.status(200);
        res.json(hhhsToDump);

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

export async function getCurrentHHH(req: Request, res: Response, next: NextFunction) {
    
    let year = new Date().getFullYear().toString();
    console.log(year);
    try {

        // get current year's HHH
        let hhh: hhhInterface.HHH | null = await HHH.findOne({id: year}).exec();

        if (hhh === null) {
            res.status(400);
            res.statusMessage = 'No HHH 100 event was found.';
            res.send({
                'status': 400,
                'message': res.statusMessage,
                'statusText': 'Bad Request'
            });

        // if found
        } else {
            console.log(hhh);
            res.status(200);
            res.json(hhh);
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


export async function createHHHs(req: Request, res: Response) {

    // check for the password
    if (req.query.pass !== CREATE_EVENTS_PASS) {
        console.log(req.query.pass);
        res.sendStatus(403);
    } else {
        let hhhs: hhhInterface.HHH[] = HHHs;

        // save HHHs to mongodb
        hhhs.forEach(async (hhh) => {
            let hhhModel = new HHH(hhh);
            try {         
                await hhhModel.save();
            } catch (error) {
                console.log(error);
                if (error.code === 11000) {
                    console.log('HHH already exists.');
                    await hhhModel.update(hhh);
                } else {
                    res.status(400);
                    res.send(error);
                }
            }
        }); // end foreach
        res.sendStatus(200);
    }


}

'use strict';
import express from 'express';
import * as HHH from '../controllers/hhhController';

export function hhhRoutes(app: express.Application) {

    // HHH Routes
    app.route('/HHHs')
        .get(HHH.getHHHs)

    app.route('/currentHHH')
        .get(HHH.getCurrentHHH);

    app.route('/createAllHHHs')
        .get(HHH.createHHHs);
};
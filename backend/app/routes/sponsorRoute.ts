'use strict';
import express from 'express';
import * as Sponsor from '../controllers/sponsorController';

export function sponsorRoutes(app: express.Application) {

    // HHH Routes
    app.route('/sponsors')
        .get(Sponsor.getSponsorsByYear)

    app.route('/createAllSponsors')
        .get(Sponsor.createSponsors);
};
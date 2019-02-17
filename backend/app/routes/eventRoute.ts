'use strict';
import express from 'express';
import * as Event from '../controllers/eventController';

export function eventRoutes(app: express.Application) {

    // Event Routes

    app.route('/events')
        .get(Event.getEvents)

    app.route('/events/:eventId')
        .get(Event.getEvent);

    app.route('/createAllEvents')
        .get(Event.createEvents);


};
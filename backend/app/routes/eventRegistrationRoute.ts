'use strict';
import express from 'express';
import * as EventRegistration from '../controllers/eventRegistrationController';

export function eventRegistrationRoutes(app: express.Application) {

    // `EventRegistration` routes
    app.route('/eventRegistrations')
        .get(EventRegistration.getEventRegistrationsByUser)
        .post(EventRegistration.createEventRegistration)
        .delete(EventRegistration.deleteEventRegistration)
};
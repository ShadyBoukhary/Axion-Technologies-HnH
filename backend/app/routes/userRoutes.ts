'use strict';
import express from 'express';
import * as User from '../controllers/userController';
import { verifyToken } from '../verifyToken';

export function userRoutes(app: express.Application) {

  // user Routes

  app.route('/')
    .get(User.getUsersByParam);

  app.route('/users')
    .get(User.getUsersByParam)
    .post(User.createUser);

  app.route('/users/:userId')
    .get(verifyToken, User.getUser)
    .put(verifyToken, User.updateUser)
    .delete(verifyToken, User.deleteUser);

  app.route('/forgotPassword')
    .get(User.forgotPassword);

  app.route('/resetPassword')
    .get(User.resetPassword);

  app.route('/newPassword')
    .get(User.newPassword);

  app.route('/login')
    .post(User.login);
};
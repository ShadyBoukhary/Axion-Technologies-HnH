'use strict';
import { SECRET_KEY } from '../config';
import { UserSchema } from '../models/userModel';
import { Document, model } from 'mongoose';
import { Request, Response } from 'express-serve-static-core';
import { NextFunction } from 'connect';
import { IUser } from '../interfaces/user';
import { IUserModel } from '../interfaces/userModel';
import jwt from 'jsonwebtoken';



const User = model<IUser, IUserModel>('User', UserSchema);

export async function getUsers(req: Request, res: Response) {
    console.log('hi');
    try {
        let usersDoc: Document[] = await User.find({}).exec();
        console.log(usersDoc);
        res.status(200);
        res.json(usersDoc);
    } catch (error) {
        res.send(error);
    }
}

export function createUser(req: Request, res: Response, next: NextFunction) {
    console.log(req.body);
    console.log(req.body.email);
    console.log(req.body.firstName);
    if (!req.body.email || !req.body.password) {
        res.status(400).send({
            'status': '400',
            'message': 'Missing Fields',
            'statusText': 'Bad Request'
        });
        return next(new Error('Missing Fields'));
    }
    req.body.firstName = req.body.lastName = 'Unspecified';

    let newUser = new User(req.body);
    newUser.save(function (err, user) {
        if (err) {
            if (err.code === 11000) {
                res.status(400).send({
                    'status': '400',
                    'message': 'User already exists.',
                    'statusText': 'Bad Request'
                });
            }

            return next(err);

        }
        res.status(200);
        res.send({
            firstName: user.firstName,
            lastName: user.lastName,
            uid: user._id,
            email: user.email
        });
    });
};

export function getUser(req: Request, res: Response) {
    console.log('*********************************************************');
    User.findById(req.params.userId, function (err, user) {
        console.log(err);
        console.log(user);
        if (err) {
            res.send(err);
        } else if (user === null) {
            res.status(404);
            res.json({
                'status': '404',
                'message': 'User not found',
                'statusText': 'Not found'
            });

        } else {
            res.status(200);
            res.send({
                'uid': user._id,
                'email': user.email,
                'firstName': user.firstName,
                'lastName': user.lastName
            });
        }
    });
};

export function updateUser(req: Request, res: Response) {
    console.log(req.params.userId);
    console.log(req.body);
    User.findOneAndUpdate({ _id: req.params.uid }, { 'firstName': req.body.firstName, 'lastName': req.body.lastName }, { new: true }, function (err, user) {
        if (err) {
            res.send(err);
        } else {
            res.status(200);
            console.log(user);
            res.json(user);
        }
    });
};

export function deleteUser(req: Request, res: Response) {
    User.remove({ _id: req.params.uid }, (err) => {
        if (err) {
            res.send(err);
        } else {
            res.status(200);
            res.json({ message: 'User Successfully Deleted!' });
        }
    });


};

/* POST Route for login */
export async function login(req: Request, res: Response, next: NextFunction) {
    if (req.body.email && req.body.password) {

        try {
            let user: IUser = await User.authenticate(req.body.email, req.body.password);
            let token = jwt.sign({ id: user._id }, SECRET_KEY, { expiresIn: 1000000 });
            res.status(200).send({
                user: {
                    uid: user._id,
                    email: user.email,
                    firstName: user.firstName,
                    lastName: user.lastName
                },
                token: token,
                auth: true
            });
        } catch (error) {
            res.status(400);
            res.statusMessage = error;
            res.send({
                'status': 400,
                'message': error,
                'statusText': 'Bad Request'
            });
            return next(error);
        }

    } else {
        var err = new Error('All fields are required.');
        res.statusMessage = err.message;
        res.status(400).send({
            'status': 400,
            'message': err.message,
            'statusText': 'Bad Request'
        });

        return next(err);
    }
};

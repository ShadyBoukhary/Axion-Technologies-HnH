'use strict';
import { SECRET_KEY, GMAIL_SERVICE_NAME, GMAIL_USER_NAME, GMAIL_USER_PASSWORD, BASE_URL } from '../config';
import { UserSchema } from '../models/userModel';
import { Document, model } from 'mongoose';
import { Request, Response } from 'express-serve-static-core';
import { NextFunction } from 'connect';
import { IUser } from '../interfaces/user';
import { IUserModel } from '../interfaces/userModel';
import jwt from 'jsonwebtoken';
import { SendMailOptions, createTransport } from 'nodemailer';
import { MailOptions } from 'nodemailer/lib/stream-transport';
import { PassReset } from '../models/passwordResetModel';
import { IPasswordReset } from '../interfaces/passwordReset/resetPasswordDocument';
var path = require('path');



const User = model<IUser, IUserModel>('User', UserSchema);

var transporter = createTransport({
    service: GMAIL_SERVICE_NAME,
    auth: {
        user: GMAIL_USER_NAME,
        pass: GMAIL_USER_PASSWORD
    }
});


export async function getUsersByParam(req: Request, res: Response) {
    res.send('<h2>To be implemented<h2>');
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
            res.sendStatus(200);
        }
    });
};


/**
 *  POST Route for login
 *  Authenticates the User. 
 *  Returns status 400 if the User could not be authenticated 
 *
 * @export async login
 * @param {Request} req
 * @param {Response} res
 * @param {NextFunction} next
 * @returns void
 */
export async function login(req: Request, res: Response, next: NextFunction) {
    if (req.body.email && req.body.password) {

        try {
            // authenticate user
            let user: IUser = await User.authenticate(req.body.email, req.body.password);
            // generate login jwt token
            let token = jwt.sign({ id: user._id }, SECRET_KEY, { expiresIn: 1000000 });

            // send user back along with jwt token
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

            // handle any errors
        } catch (error) {
            console.log('sdasdsadsad');
            res.status(400);
            res.statusMessage = error;
            res.send({
                'status': 400,
                'message': error,
                'statusText': 'Bad Request'
            });
        }

        // handle missing fields
    } else {
        var err = new Error('All fields are required.');
        res.statusMessage = err.message;
        res.status(400).send({
            'status': 400,
            'message': err.message,
            'statusText': 'Bad Request'
        });
    }
};

/**
 * Sends an email to a user to reset their password.
 *
 * @export
 * @param {Request} req
 * @param {Response} res
 * @param {NextFunction} next
 */
export async function forgotPassword(req: Request, res: Response, next: NextFunction) {
    let email = req.query.email;
    console.log(`Forgot Password: ${email}`);

    // Verify query params were sent
    if (!email) {
        res.status(400);
        res.statusMessage = 'No email was provided.';
        res.send({
            'status': 400,
            'message': res.statusMessage,
            'statusText': 'Bad Request'
        });
    } else {

        try {
            let user = await User.findOne({email: email}).exec();
            if (user === null) {
                console.log('Email not found');
                throw Error('No users with that email are registered in our system.');
            }
            // Create new document
            let token = Math.floor(Date.now() / 1000).toString();
            let passwordReset = new PassReset({ email: email, uid: user._id, token: token });
            // Save documment
            await PassReset.updateOne({ uid: user._id, email: email }, {
                token: passwordReset.token,
                email: passwordReset.email,
                uid: passwordReset.uid
            }, { upsert: true }).exec();
            await sendEmail(passwordReset);
            res.status(200).send({'status': 200});
        } catch (error) {
            console.log(error);
            res.statusMessage = error.message;
            res.status(400).send({
                'status': 400,
                'message': error.message,
                'statusText': 'Bad Request'
            });
        }
    }
}

async function sendEmail(passReset: IPasswordReset) {
    console.log(passReset);
    let options: MailOptions = {
        from: `"Hotter\'n Hell Mobile App Mailer" <${GMAIL_USER_NAME}>`,
        to: passReset.email,
        subject: 'Password Reset',
        html:
            `<p>You are receiving this email because you have requested to change your password. If you did not make this request, please ignore this email.

        Otherwise, please click on the link below to reset your password.</p>

        <a href='${BASE_URL}/resetPassword?uid=${passReset.uid}&token=${passReset.token}'>Reset My Password Now</a>
        `
    };

    try {
        let info = await transporter.sendMail(options);
        console.log(`Email sent: ${info.response}`);
    } catch (error) {
        console.log('Could not send email.');
        throw error;
    }
}

export async function resetPassword(req: Request, res: Response) {
    let token = req.query.token;
    let uid = req.query.uid

    if (!token || !uid) {
        res.status(400);
        res.statusMessage = 'Missing fields.';
        res.send({
            'status': 400,
            'message': res.statusMessage,
            'statusText': 'Bad Request'
        });
    } else {
        let user = await User.findById(uid).exec();
        if (user == null) {
            res.status(400);
            res.statusMessage = 'User not found.';
            res.send({
                'status': 400,
                'message': res.statusMessage,
                'statusText': 'Bad Request'
            });
        } else {
            if (req.session) {
                req.session.uid = uid;
                req.session.token = token;
                console.log(req.session);
                res.sendFile(path.join(__dirname+'/../../app/controllers/forgot.html'));
            }

        }
    }
}

export async function newPassword(req: Request, res: Response, next: NextFunction) {
    let pass = req.query.pass;
    let confirm = req.query.confirm;
    if (!pass || !confirm) {
        res.status(400);
        res.statusMessage = 'Missing fields.';
        res.send({
            'status': 400,
            'message': res.statusMessage,
            'statusText': 'Bad Request'
        });
    } else if (pass !== confirm) {
        res.status(400);
        res.statusMessage = 'Passwords do not match.';
        res.send({
            'status': 400,
            'message': res.statusMessage,
            'statusText': 'Bad Request'
        });
    } else {
        console.log(req.session);
        if (req.session) {
            let token = req.session.token;
            let uid = req.session.uid;
            let passReset = await PassReset.findOne({token: token, uid: uid}).exec();
            if (passReset === null) {
                res.sendStatus(403);
            } else {
                try {
                    let user = await User.findById({ _id: uid}).exec();
                    if (user) {
                        user.password = pass;
                    }
                    await (user as IUser).save();
                    await passReset.remove();
                    res.sendStatus(200);
                } catch (error) {
                    console.log(error);
                    return next(error);
                }
            }
        }
    }
}

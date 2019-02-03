import { SECRET_KEY } from './config';
import { VerifyCallback, VerifyErrors , verify } from 'jsonwebtoken';

/**
 *
 *
 * @param {*} req
 * @param {*} res
 * @param {*} next
 * @returns
 */
export function verifyToken(req: any, res: any, next: any) {
    var token = req.headers['x-access-token'];
    if (!token)
        return res.status(403).send({ auth: false, message: 'No token provided.' });
    verify(token, SECRET_KEY, (err: VerifyErrors, decoded: any) => {
        if (err)
            return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });
        // if everything good, save to request for use in other routes
        req.userId = decoded.id;
        next();
    });
}
//module.exports = verifyToken;

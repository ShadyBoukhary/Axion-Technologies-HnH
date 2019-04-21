// app/app.ts
import * as bodyParser from "body-parser";
import express from 'express';
import * as path from "path";
import cors from "cors";
import { connect } from 'mongoose';
import { MONGO_CREDS } from './mongoConfig';
import session from 'express-session';
// import routes
import { userRoutes } from './routes/userRoutes';
import { eventRoutes } from "./routes/eventRoute";
import { eventRegistrationRoutes } from './routes/eventRegistrationRoute';
import { hhhRoutes } from "./routes/hhhRoute";
import { sponsorRoutes } from "./routes/sponsorRoute";
import { SESSION_SECRET } from "./config";
import cookieParser = require("cookie-parser");

class Server {
    public app: express.Application;
    private port: number;


    constructor() {
        this.app = express();
        this.port = 8000;
        this.config();
        this.routes();
        this.initDB();
    }

    public static bootstrap(): Server {
        return new Server();
    }

    /**
   * Configure application
   *
   * @class Server
   * @method config
   * @return void
   */
  private config() {

    //mount json form parser
    this.app.use(bodyParser.json());

    //mount query string parser
    this.app.use(bodyParser.urlencoded({ extended: true }));
    this.app.use(cors());
    //add static paths
    this.app.use(express.static(path.join(__dirname, "public")));
    this.app.use(express.static(path.join(__dirname, "bower_components")));
    this.app.listen(this.port, () => console.log(`Listening to port ${this.port}`));
    this.app.use(cookieParser());
    this.app.use(session({secret: SESSION_SECRET}));


  }

    /**
   * Configure routes
   *
   * @class Server
   * @method routes
   * @return void
   */
  private routes() {
    userRoutes(this.app);
    eventRoutes(this.app);
    eventRegistrationRoutes(this.app);
    hhhRoutes(this.app);
    sponsorRoutes(this.app);
  }

  private initDB() {
      connect('mongodb://localhost/hnhDB', {user: MONGO_CREDS.username, pass: MONGO_CREDS.password, authdb: 'admin'});
  }
}

var server = Server.bootstrap();
export = server.app;
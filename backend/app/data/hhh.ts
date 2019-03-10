import { HHH } from "../interfaces/non_modals/hhh";
import { EVENTS } from './events';
import { SPONSORS } from "./sponsors";

export const HHHs: HHH[] = [
    {
        id: '2019',
        description: 'A lot of things are going on during the HHH weekend but there is no way to describe the electrifying experience of the START. Riders begin to assemble as early as 4AM. They are joined by 10,000+ other riders who have trained to complete their chosen distances. All that pent up human energy is unleashed after the American National Anthem, Air Force Fly Over and Cannon Blast. If you are going to ride 100 miles, the best place to do it is at the Hotter’N Hell Hundred!',
        mailingAddress: 'Hotter\'N Hell Hundred, PO Box 2099, Wichita Falls, TX 76307',
        timestamp: '1566622800',
        sponsors: SPONSORS.filter((sponsor) => sponsor.year === '2019').map((sponsor) => sponsor.name),
        events:  EVENTS.map((event) => event._id),
    },
    {
        id: '2018',
        description: 'A lot of things are going on during the HHH weekend but there is no way to describe the electrifying experience of the START. Riders begin to assemble as early as 4AM. They are joined by 10,000+ other riders who have trained to complete their chosen distances. All that pent up human energy is unleashed after the American National Anthem, Air Force Fly Over and Cannon Blast. If you are going to ride 100 miles, the best place to do it is at the Hotter’N Hell Hundred!',
        mailingAddress: 'Hotter\'N Hell Hundred, PO Box 2099, Wichita Falls, TX 76307',
        timestamp: '1566622800',
        sponsors: SPONSORS.filter((sponsor) => sponsor.year === '2018').map((sponsor) => sponsor.name),
        events: EVENTS.map((event) => event._id),
    }
];  
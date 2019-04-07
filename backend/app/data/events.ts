import { Event } from "../interfaces/non_modals/event";
import { TwentyFiveMileRouteCoordinates } from "./routes/25_mile.gpxCoordinates";
import { FiftyMileRouteCoordinates } from "./routes/50_mile.gpxCoordinates";
import { OneHundredKMRouteCoordinates } from "./routes/100_km.gpxCoordinates";
import { OneHundredMileRouteCoordinates } from "./routes/100_mile.gpxCoordinates";

// create events
const Dinners: Event[] = [
    {
        _id: '5c68c740cf2095b99753c693',
        name: 'Spagetti Dinner',
        description: 'The Spaghetti dinner is presented by the members of the North Texas Restaurant Association with all proceeds going to benefit their charities primarily the Wichita Falls Interfaith Ministries.\nWhere: Lower Level MPEC Coliseum \nDate: Friday, August 23, 2019 \nTime: 5:30 PM to 9:00 PM \nCost: $10 in advance or at the door',
        location: { lat: '33.915518', lon: '-98.499189', timestamp: '1566599400'},
        route: [],
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w',
        isFeatured: true
    },
    {
        _id: '5a64d752cf1085b92753c696',
        name: 'Breakfast Buffet',
        description: `SPECTRA FOOD & HOSPITALITY WILL BE PRESENTING A FULL BREAKFAST BUFFET FOR RIDERS
Where: Lower Level MPEC Coliseum

Date: Saturday, August 24, 2019

Time: 5:00 AM to 7:00 AM

Price: Only $10.00 in advance or at the door`,
        location: { lat: '33.915518', lon: '-98.499189', timestamp: '1566554400'},
        route: [],
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w',
        isFeatured: true
    },
]

const ConsumerShowAndFinishLine: Event[] = [
    {
        _id: '5c68c740cf2095b53753c293',
        name: 'Consumer Show',
        description: `The 2019 HHH Consumer Show will be in the MPEC Exhibit Hall. There will be over 90 vendors offering all sorts of cycling related products.

Consumer Show Hours:
    
Thursday, August 22, 2019, 3:00pm – 8pm
Friday, August 23, 2019, 1:00pm – 10:00pm
Saturday, August 24, 2018, 9am – 2pm`,
        location: { lat: '33.915518', lon: '-98.499189', timestamp: '1566504000'},
        route: [],
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762f3e4be659492f0394165/1466102758272/DSC_2378.JPG',
        isFeatured: true
    },
    {
        _id: '5c28c470cf2095c99753c693',
        name: 'Finish Line Village',
        description: `The Finish Line Village - FLV -  is an elaborate food and entertainment venue adjacent to the HHH Endurance Ride finish line and the Consumer Show. Vendors offer a variety of culinary delights and cycling related products throughout the late afternoon and evening Friday and all day Saturday.

Finish Line Village hours:

Friday, August 23, 2018, 3:00PM – 10:00PM
Saturday, August 24, 2018, 8:00AM – 6:00PM
Sunday, August 25, 2018, Optional 7:00AM – 2:00PM'`,
        location: { lat: '33.915518', lon: '-98.499189', timestamp: '1566590400'},
        route: [],
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762f4dc6b8f5b87e313f735/1466103020625/',
        isFeatured: true
    },
]

export const EVENTS: Event[] = [
    {
        _id: '5c68d750cf2095b99753c693',
        name: 'Hotter \'n Hell Hundred 25 Mile Race',
        description: 'Hotter \'n Hell Hundred 25 Mile Race',
        location: { lat: '352523525', lon: '2423523525', timestamp: (Math.floor(Date.now() / 1000)).toString() },
        route: TwentyFiveMileRouteCoordinates,
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w',
        isFeatured: false
    },
    {
        _id: '5a68d750cf1095b92753c696',
        name: 'Hotter \'n Hell Hundred 50 Mile Race',
        description: 'Hotter \'n Hell Hundred 50 Mile Race',
        location: { lat: '35251223525', lon: '24234321523525', timestamp: (Math.floor(Date.now() / 1000)).toString() },
        route: FiftyMileRouteCoordinates,
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w',
        isFeatured: false
    },
    {
        _id: '5a68d750cf1095b92753c695',
        name: 'Hotter \'n Hell Hundred 100 Kilometer Race',
        description: 'Hotter \'n Hell Hundred 100 Kilometer Race',
        location: { lat: '352522343525', lon: '2423234523525', timestamp: (Math.floor(Date.now() / 1000)).toString() },
        route: OneHundredKMRouteCoordinates,
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w',
        isFeatured: false
    },
    {
        _id: '5a68d740df1094b82752c695',
        name: 'Hotter \'n Hell Hundred 100 Mile Race',
        description: 'Hotter \'n Hell Hundred 100 Mile Race',
        location: { lat: '352522343525', lon: '2423234523525', timestamp: (Math.floor(Date.now() / 1000)).toString() },
        route: OneHundredMileRouteCoordinates,
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w',
        isFeatured: false
    },
    ...Dinners,
    ...ConsumerShowAndFinishLine,
]



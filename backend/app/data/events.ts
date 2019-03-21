import { Event } from "../interfaces/non_modals/event";

// create events

export const EVENTS: Event[] = [
    {
        _id: '5c68d750cf2095b99753c693',
        name: 'Lorem Ipsum',
        description: 'Lorem Ipsum dolor sir.',
        location: { lat: '352523525', lon: '2423523525', timestamp: (Date.now() / 1000).toString() },
        route: [{ lat: '234234234', lon: '4234234243' }],
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w'
    },
    {
        _id: '5a68d750cf1095b92753c696',
        name: 'Lorem Ipsum',
        description: 'Lorem Ipsum dolor sir.',
        location: { lat: '35251223525', lon: '24234321523525', timestamp: (Date.now() / 1000).toString() },
        route: [{ lat: '2342321214234', lon: '4234224334243' }],
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w'
    },
    {
        _id: '5a68d750cf1095b92753c695',
        name: 'Lorem Ipsum',
        description: 'Lorem Ipsum dolor sir.',
        location: { lat: '352522343525', lon: '2423234523525', timestamp: (Date.now() / 1000).toString() },
        route: [{ lat: '23423423234', lon: '423423124243' }],
        imageUrl: 'https://static1.squarespace.com/static/5755853d20c6478394a9a05c/t/5762dc38e3df28879d163bc3/1466096766456/?format=1500w'
    }
]

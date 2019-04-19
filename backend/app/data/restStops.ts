import { Coordinates } from "../interfaces/non_modals/coordinates";

const HellsGate: Coordinates = { lon: '-98.558208', lat: '34.078956' };
const FinishLine: Coordinates = { lon: '-98.448825', lat: '33.900523' };
const Medical: Coordinates = { lon: '-98.497258', lat: '33.916706' };
const Other: Coordinates[] = [
    { lon: '-98.497591', lat: '33.918173' },
    { lon: '-98.666825', lat: '33.950939' },
    { lon: '-98.818108', lat: '33.911806' },
    { lon: '-98.909941', lat: '34.026606' },
    { lon: '-98.828858', lat: '34.091389' },
    { lon: '-98.630887', lat: '34.096625' },
    { lon: '-98.558043', lat: '34.089795' },
    { lon: '-98.425258', lat: '34.044389' },
    { lon: '-98.326458', lat: '34.085156' },
    { lon: '-98.373075', lat: '34.030456' },
    { lon: '-98.354391', lat: '33.944373' },
    { lon: '-98.831508', lat: '34.058006' },
    { lon: '-98.679341', lat: '34.064839' },
    { lon: '-98.552825', lat: '34.013689' },
    { lon: '-98.50771', lat: '33.972682' },
    { lon: '-98.620586', lat: '33.949484' },
    { lon: '-98.710175', lat: '33.966506' },
    { lon: '-98.497508', lat: '33.916873' },
    { lon: '-98.511608', lat: '33.916773' },
    { lon: '-98.415706', lat: '33.91462' },
    { lon: '-98.475271', lat: '33.914008' }
];

export const Stops: Coordinates[] = [
    HellsGate,
    FinishLine,
    Medical,
    ...Other

];

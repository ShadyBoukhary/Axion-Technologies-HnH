import { Coordinates } from '../interfaces/non_modals/coordinates';
import * as fs from 'fs';

const gpx = require('parse-gpx');

var baseUrl = './app/data/routes/';
var files = [`${baseUrl}25_mile.gpx`, `${baseUrl}50_mile.gpx`, `${baseUrl}100_km.gpx`, `${baseUrl}100_mile.gpx`];
var names = ['TwentyFiveMileRoute', 'FiftyMileRoute', 'OneHundredKMRoute', 'OneHundredMileRoute'];

// create a ts file with the coordinates for each GPX file
files.forEach(async (file, index) => {
    let coordinates = await getCoordinatesFromGPX(file);
    let contents = createFileContents(names[index], coordinates);
    createFile(file, contents);
});


/**
 *
 * Parses a GPX file and retrieves a `Coordinates[]` to be used for the events
 * @param {string} file
 * @returns {Promise<Coordinates[]>}
 */
async function getCoordinatesFromGPX(file: string): Promise<Coordinates[]> {
    let tracks: any[] = await gpx(file);
    return <Coordinates[]>tracks.map((track) => <Coordinates>{ lat: track.latitude, lon: track.longitude });
}

/**
 *
 * Creates a file and dumps contents into it
 * @param {string} file
 * @param {string} contents
 */
function createFile(file: string, contents: string) {

    fs.writeFile(`${file}Coordinates.ts`, contents, function (err) {
        if (err) {
            return console.error(err);
        }
        console.log("File created!");
    });

}

/**
 *
 * Creates a string that can be written to a `ts` file with correct syntax
 * The string returned should declare a {Coodinates[]} with the routes to be used
 * in other parts of the code to populate the database
 * @param {string} name
 * @param {Coordinates[]} coordinates
 * @returns {string} 
 */
function createFileContents(name: string, coordinates: Coordinates[]) {

    return `
import { Coordinates } from '../../interfaces/non_modals/coordinates';
export const ${name}Coordinates: Coordinates[] = 
    ${JSON.stringify(coordinates)};
    `
}
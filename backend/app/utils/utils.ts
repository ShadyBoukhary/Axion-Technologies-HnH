import { Coordinates } from '../interfaces/non_modals/coordinates';

const gpx = require('parse-gpx');

export const getCurrentYear = () => new Date().getFullYear().toString();


export async function getCoordinatesFromGPX(file: string): Promise<Coordinates[]> {
    let tracks: any[] = await gpx(file);
    return <Coordinates[]>tracks.map((track) => <Coordinates>{lat: track.latitude, lon: track.longitude});
}
import './sensitive.dart';

class Constants {

    // APIs
    static const String baseUrl = 'http://$baseUrlNoPrefix';
    static const String usersRoute = '$baseUrl/users';
    static const String loginRoute = '$baseUrl/login';
    static const String eventsRoute = '$baseUrl/events';
    static const String eventRegistrationsRoute = '$baseUrl/eventRegistrations';
    static const String allHHHRoute = '$baseUrl/HHHs';
    static const String currentHHHRoute = '$baseUrl/currentHHH';

    // APIs no prefix
    static const String baseUrlNoPrefix = '45.32.197.143:8000';
    static const String googleApi = 'maps.googleapis.com';
    static const String google = 'google.com';
    static const String googleLocalPlacesPath = '/maps/api/place/nearbysearch/json';
    static const String googlePlacesPhotoPath = '/maps/api/place/photo';
    static const String gooleDirectionsPath = '/maps/api/directions/json';
    static const String googlePlacePath = '/maps/place';
    static const String eventsPathOnly = '/events';
    static const String sponsorsPathOnly = '/sponsors';
    static const String eventRegistrationsPathOnly = '/eventRegistrations';


    // Local Storage
    static const String tokenKey = 'authentication_token';
    static const String userKey = 'user_key';
    static const String isAuthenticatedKey = 'isUserAuthenticated';

    // Google API
    static const String placesApiKey = googleApiKey;
    static const String placesRadius = '10000';
}
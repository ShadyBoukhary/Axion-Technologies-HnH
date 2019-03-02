class Constants {
    static const String baseUrl = 'http://$baseUrlNoPrefix';
    static const String baseUrlNoPrefix = '45.32.197.143:8000';
    static const String usersRoute = '$baseUrl/users';
    static const String loginRoute = '$baseUrl/login';
    static const String eventsRoute = '$baseUrl/events';
    static const String eventRegistrationsRoute = '$baseUrl/eventRegistrations';

    static const String eventsPathOnly = '/events';
    static const String tokenKey = 'authentication_token';
    static const String userKey = 'user_key';
    static const String isAuthenticatedKey = 'isUserAuthenticated';
}
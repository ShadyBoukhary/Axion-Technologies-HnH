class APIException implements Exception  {
  final String message;
  final int statusCode;
  final String statusText;

  APIException(this.message, this.statusCode, this.statusText);
}
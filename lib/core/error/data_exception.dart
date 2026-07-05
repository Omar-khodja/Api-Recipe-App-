class ApiExceptions implements Exception {
  final String message;

  ApiExceptions(this.message);

  @override
  String toString() => 'ApiException: $message';
}
class LocalDataBaseExceptions implements Exception {
  final String message;

  LocalDataBaseExceptions(this.message);

  @override
  String toString() => 'LocalDataBaseException: $message';
}

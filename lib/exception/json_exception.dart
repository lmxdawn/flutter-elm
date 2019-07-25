class JsonException implements Exception {

  final int code;

  final String message;

  JsonException(this.code, this.message);

}
class ExceptionJson implements Exception {

  final int status;

  final String message;

  ExceptionJson([this.status, this.message]);

  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }

}
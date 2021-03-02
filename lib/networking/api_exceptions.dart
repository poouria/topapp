class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "خطا در برقرراری ارتباط:");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "درخواست نا معتبر است: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "خطای دسترسی: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message])
      : super(message, "ورودی نا معتبر است: ");
}

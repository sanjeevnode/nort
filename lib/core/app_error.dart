// ignore_for_file: public_member_api_docs

abstract class AppException implements Exception {
  AppException({
    this.code = '',
    this.message = '',
    this.data,
  });

  final String code;
  final String message;
  final dynamic data;

  @override
  String toString() => message;
}

class BadRequestException extends AppException {
  BadRequestException({
    super.code,
    super.message = 'Bad Request',
    super.data,
  });
}

class DataParsingException extends AppException {
  DataParsingException({
    super.code,
    super.message = 'An error occurred when parsing data',
    super.data,
  });
}

class UnexpectedException extends AppException {
  UnexpectedException({
    super.code,
    super.message = 'Unexpected error has occurred',
    super.data,
  });
}

extension AppErrorExtension on Object {
  AppException toAppException() {
    if (this is AppException) {
      return this as AppException;
    }
    return UnexpectedException(message: toString());
  }
}

class UserNotFoundException extends AppException {
  UserNotFoundException({
    super.code,
    super.message = 'User not found',
    super.data,
  });
}

class UserAlreadyExistsException extends AppException {
  UserAlreadyExistsException({
    super.code,
    super.message = 'User already exists',
    super.data,
  });
}

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException({
    super.code,
    super.message = 'Invalid credentials',
    super.data,
  });
}

class UserNotLoggedInException extends AppException {
  UserNotLoggedInException({
    super.code,
    super.message = 'User not logged in',
    super.data,
  });
}

class NoteNotFoundException extends AppException {
  NoteNotFoundException({
    super.code,
    super.message = 'Note not found',
    super.data,
  });
}

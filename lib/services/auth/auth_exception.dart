//login view exceptions

class UserNotFoundAuthException implements Exception{}

class WrongPasswordAuthException implements Exception{}

//register view execeptions

class InvalidEmailAuthException implements Exception{}

class WeakPasswordAuthException implements Exception{}

class EmailAlreadyInUseAuthException implements Exception{}

//generic exceptions

class GenericAuthException implements Exception{}

class UserNotLoggedInAuthException implements Exception{}


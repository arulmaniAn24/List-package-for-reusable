import 'package:nitrite/nitrite.dart';

/// Thrown during the login process if a failure occurs.
class LoginFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class LoginRepository {
  /// {@macro uba_repository}
  const LoginRepository({
    required Nitrite localDB,
  }) : _localDB = localDB;

  final Nitrite _localDB;
}

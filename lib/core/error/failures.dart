import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

// Validation Failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

// GraphQL Failures
class GraphQLFailure extends Failure {
  const GraphQLFailure(super.message);
}

// General Failures
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

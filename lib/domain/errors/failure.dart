// ignore_for_file: public_member_api_docs, sort_constructors_first
/// An abstract class representing a generic failure.
///
/// This class is extended by specific failure types and provides a base implementation
/// for handling error messages. It extends [Equatable] to support value comparison.
abstract class Failure {
  /// The error message associated with the failure.
  final String message;

  /// Creates a [Failure] with the given error message.
  ///
  /// The [message] parameter is required and provides a description of the failure.
  const Failure({required this.message});

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

/// A class representing a server failure.
///
/// This failure occurs when there is an issue with the server.
final class ServerFailure extends Failure {
  /// Creates a [ServerFailure] with the given error message.
  ///
  /// The [message] parameter is required and provides a description of the server failure.
  const ServerFailure({required super.message});
}

/// A class representing a connection failure.
///
/// This failure occurs when there is an issue with the network connection.
final class ConnectionFailure extends Failure {
  /// Creates a [ConnectionFailure] with the given error message.
  ///
  /// The [message] parameter is required and provides a description of the connection failure.
  const ConnectionFailure({required super.message});
}

/// A class representing a database failure.
///
/// This failure occurs when there is an issue with the database.
final class DatabaseFailure extends Failure {
  /// Creates a [DatabaseFailure] with the given error message.
  ///
  /// The [message] parameter is required and provides a description of the database failure.
  const DatabaseFailure({required super.message});
}

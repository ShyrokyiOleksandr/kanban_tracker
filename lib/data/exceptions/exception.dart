/// A custom exception class representing a server exception.
///
/// This exception is thrown when an error occurs while communicating with the server.
/// It contains a [message] describing the error.
class ServerException implements Exception {
  /// The error message associated with the exception.
  final String message;

  /// Creates a [ServerException] with the given error [message].
  const ServerException({required this.message});
}

class ConnectionException implements Exception {
  /// The error message associated with the exception.
  final String message;

  /// Creates a [ConnectionException] with the given error [message].
  const ConnectionException({required this.message});
}

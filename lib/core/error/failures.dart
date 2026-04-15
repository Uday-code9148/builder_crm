class Failure {
  final String message;

  const Failure([this.message = 'Something went wrong!']);

  /// Wraps any caught exception into a [Failure].
  factory Failure.handleException(Object e) => Failure(e.toString());

  factory Failure.server([String? message]) => Failure(message ?? 'Server error occurred');

  factory Failure.cache([String? message]) => Failure(message ?? 'Cache error occurred');

  factory Failure.network([String? message]) => Failure(message ?? 'No internet connection');

  factory Failure.unauthorized([String? message]) => Failure(message ?? 'Unauthorized');

  @override
  String toString() => 'Failure(message: $message)';
}

class ConfirmationRequiredFailure extends Failure {
  final String email;

  const ConfirmationRequiredFailure(this.email) : super('Account not confirmed. Please check your email for a verification code.');
}

class ExceptionHandler {
  static String toUserFriendlyMessage(dynamic error) {
    if (error is String) return error;

    final message = error.toString();

    if (message.contains('Wrong Credentials')) {
      return 'Incorrect email or password. Please try again.';
    }

    return 'Something went wrong. Please try again later.';
  }
}

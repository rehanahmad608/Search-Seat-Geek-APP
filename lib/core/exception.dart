class BaseException implements Exception {
  BaseException(this.message, {this.details});

  final String message;
  final Object? details;

  @override
  String toString() {
    final detailsStr = details == null ? '' : '. Details: $details';
    return '$message$detailsStr';
  }
}

class Failure {
  final String message;
  final int? code;

  Failure({required this.message, this.code});

  @override
  String toString() => 'Failure($message, $code)';
}

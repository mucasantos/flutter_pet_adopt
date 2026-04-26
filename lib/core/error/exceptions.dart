class ServerException implements Exception {
  const ServerException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;
}

class ParsingException implements Exception {
  const ParsingException({required this.message});

  final String message;
}

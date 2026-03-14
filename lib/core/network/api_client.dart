import 'dart:convert';
import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  const ApiClient({
    required this.client,
    required this.host,
  });

  final http.Client client;
  final String host;

  Future<Map<String, dynamic>> get(String endpoint) async {
    final uri = Uri.https(host, endpoint);
    final response = await client.get(uri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ServerException(
        message: 'Request failed with status code ${response.statusCode}.',
        statusCode: response.statusCode,
      );
    }

    try {
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const ParsingException(message: 'Invalid response format.');
      }

      return decoded;
    } on FormatException {
      throw const ParsingException(message: 'Invalid JSON response.');
    }
  }
}

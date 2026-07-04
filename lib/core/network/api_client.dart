import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  const ApiClient({
    required this.client,
    required this.host,
  });

  final http.Client client;
  final String host;

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('https://$host$endpoint');
    final response = await client.get(uri, headers: headers);
    return _decodeResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('https://$host$endpoint');
    final response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        ...?headers,
      },
      body: jsonEncode(body ?? const {}),
    );
    debugPrint('API POST Response [$endpoint]: ${response.body}');
    return _decodeResponse(response);
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('https://$host$endpoint');
    final response = await client.delete(uri, headers: headers);
    return _decodeResponse(response);
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final decoded = jsonDecode(response.body);
      throw ServerException(
        message: decoded['message'] ??
            'Request failed with status code ${response.statusCode}.',
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

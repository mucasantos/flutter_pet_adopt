import 'dart:convert';

import 'package:flutter_pet_adopt/service/api_connect.dart';
import 'package:http/http.dart' as http;

class HttpConnect {
  static post() async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https('example.com', 'whatsit/create'),
          body: {'name': 'doodle', 'color': 'blue'});
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var uri = Uri.parse(decodedResponse['uri'] as String);
      print(await client.get(uri));
    } finally {
      client.close();
    }
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https(server, endpoint),
      );

      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      return decodedResponse;
    } finally {
      client.close();
    }
  }
}

import 'dart:convert';

import 'package:flutter_pet_adopt/service/api_connect.dart';
import 'package:http/http.dart' as http;

class HttpConnect {
  static Future<Map<String, dynamic>> getData(
      {required String endpoint}) async {
    var url = Uri.https(server, endpoint);
    var client = http.Client();
    try {
      var response = await client.get(url);
      print(response.body);

      var decodeResp = jsonDecode(response.body) as Map<String, dynamic>;
      return decodeResp;
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  static postData({required Map data, required String endpoint}) async {
    var url = Uri.https(server, endpoint);

//Codificar em json, para o backend entender!
    String body = json.encode(data);

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

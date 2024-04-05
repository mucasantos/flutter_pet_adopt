import 'dart:convert';

import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:http/http.dart' as http;

class HttpConnect {
  
  static getData({ required String endpoint}) async {
    var url = Uri.https(serverAddress, endpoint);
    var client = http.Client();
    try {
      var response = await client.get(url);
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  static postData({required Map data,required String endpoint}) async {
    var url = Uri.https(serverAddress, endpoint);

//Codificar em json, para o backend entender!
    String body =
        json.encode(data);

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

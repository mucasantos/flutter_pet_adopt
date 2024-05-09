import 'package:dio/dio.dart';
import 'package:flutter_pet_adopt/services/constants.dart';

class HTTPManager {
  Dio dio = Dio();

  //Get
  getData(String endpoint, int page) async {
    Response response;
    response = await dio.get(serverAddress + endpoint,
        queryParameters: {'page': page.toString()});
//Já retorna como Map<dynamic,String>
    return response.data;
  }
}

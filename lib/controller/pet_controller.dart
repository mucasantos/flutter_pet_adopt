import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/models/pets.dart';
import 'package:flutter_pet_adopt/service/api_connect.dart';
import 'package:flutter_pet_adopt/service/http_connect.dart';

class PetController extends ChangeNotifier {
  Pets? allPets;

  PetController() {
    getAllPets();
  }

  getAllPets() async {
    var response = await HttpConnect.getData(endpoint: Endpoints.pets);

    allPets = Pets.fromJson(response);

    notifyListeners();
  }
}

import 'package:flutter_pet_adopt/models/pet.dart';

class Pets {
  List<Pet>? pets;

  Pets({this.pets});

  Pets.fromJson(Map<String, dynamic> json) {
    if (json['pets'] != null) {
      pets = [];
      json['pets'].forEach((v) {
        pets?.add(Pet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pets != null) {
      data['pets'] = pets?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

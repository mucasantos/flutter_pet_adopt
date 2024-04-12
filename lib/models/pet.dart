import 'package:flutter_pet_adopt/models/adopter.dart';
import 'package:flutter_pet_adopt/models/user.dart';

class Pet {
  String? sId;
  String? name;
  int? age;
  int? weight;
  String? color;
  List<String>? images;
  User? user;
  bool? isVerified;
  bool? available;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Adopter? adopter;

  Pet(
      {this.sId,
      this.name,
      this.age,
      this.weight,
      this.color,
      this.images,
      this.user,
      this.isVerified,
      this.available,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.adopter});

  Pet.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    weight = json['weight'];
    color = json['color'];
    images = json['images'].cast<String>();
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    isVerified = json['isVerified'];
    available = json['available'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    adopter =
        json['adopter'] != null ? Adopter.fromJson(json['adopter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['age'] = age;
    data['weight'] = weight;
    data['color'] = color;
    data['images'] = images;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['isVerified'] = isVerified;
    data['available'] = available;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (adopter != null) {
      data['adopter'] = adopter!.toJson();
    }
    return data;
  }
}

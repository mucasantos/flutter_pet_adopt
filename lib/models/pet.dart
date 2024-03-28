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
  String? gender;
  String? breed;

  Pet({
    this.sId,
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
    this.gender,
    this.breed,
  });

  Pet.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    weight = json['weight'];
    breed = json['breed'];
    color = json['color'];
    images = json['images'].cast<String>();
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    isVerified = json['isVerified'];
    available = json['available'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    gender = json['gender'];

    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['age'] = age;
    data['weight'] = weight;
    data['breed'] = breed;
    data['color'] = color;
    data['images'] = images;
    data['gender'] = gender;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['isVerified'] = isVerified;
    data['available'] = available;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

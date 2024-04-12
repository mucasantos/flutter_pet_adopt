
class User {
  String? sId;
  String? name;
  String? email;
  String? phone;
  bool? isAdmin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? image;

  User(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.isAdmin,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isAdmin = json['isAdmin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['isAdmin'] = isAdmin;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['image'] = image;
    return data;
  }
}


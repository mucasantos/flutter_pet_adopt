
class Adopter {
  String? sId;
  String? name;
  String? image;

  Adopter({this.sId, this.name, this.image});

  Adopter.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
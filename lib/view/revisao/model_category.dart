import 'dart:convert';

class Category {
  List<CategoryElement> categories;

  Category({
    required this.categories,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class CategoryElement {
  int id;
  String name;
  String image;

  CategoryElement({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryElement.fromRawJson(String str) =>
      CategoryElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

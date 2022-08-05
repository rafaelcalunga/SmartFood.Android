import 'category.dart';

class Recipe {
  String id;
  String name;
  int preparationTime;
  int servings;
  String ingredients;
  String description;
  Category category;
  String photo;

  Recipe({
    required this.id,
    required this.name,
    required this.preparationTime,
    required this.servings,
    required this.ingredients,
    required this.description,
    required this.category,
    required this.photo,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'],
      name: json['name'],
      preparationTime: json['preparationTime'],
      servings: json['servings'],
      ingredients: json['ingredients'],
      description: json['description'],
      category: Category.fromJson(json['category']),
      photo: json['photo']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'preparationTime': preparationTime,
        'servings': servings,
        'ingredients': ingredients,
        'description': description,
        'category': category.toJson(),
        'photo': photo
      };
}

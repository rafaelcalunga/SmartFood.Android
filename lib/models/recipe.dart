
import 'category.dart';

class Recipe {
  final String id;
  final String name;
  final int preparationTime;
  final int servings;
  final String ingredients;
  final String description;
  final Category category;
  final String photo;

  const Recipe({
    required this.id,
    required this.name,
    required this.preparationTime,
    required this.servings,
    required this.ingredients,
    required this.description,
    required this.category,
    required this.photo,
  });
}
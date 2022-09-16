import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:smartfood/config/constants.dart';
import 'package:smartfood/models/recipe.dart';

class RecipesService {
  static final RecipesService instance = RecipesService._internal();
  factory RecipesService() => instance;
  RecipesService._internal();

  late Future<List<Recipe>> recipes;

  void init() async {
    recipes = fetchRecipes();
  }
 
  Future<List<Recipe>> fetchRecipes() async {
    final url = Uri.https(APP_API_URL, '/api/recipes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Recipe.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<void> deleteRecipe(String id) async {
    print("deleteRecipe, $id");

    final url = Uri.https(APP_API_URL, '/api/recipes/$id');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      //setState(() {
        recipes.then((liste) => liste.removeWhere((element) => element.id == id));
      //});
    } else {
      throw Exception('Failed to delete recipes');
    }
  }
}

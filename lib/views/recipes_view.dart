import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartfood/models/recipe.dart';
import 'package:smartfood/views/recipe_view.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

/*List<Recipe> fetchRecipes() {
  const Category category = Category(id: "123", name: "Desserts");
  return [
    const Recipe(id: "123", name: "Banana Cake", preparationTime: 2, servings: 3, ingredients: "Banana and sugar", description: "", category: category, photo: "https://picsum.photos/id/102/400/300"),
    const Recipe(id: "123", name: "Chocolate Cake", preparationTime: 4, servings: 5, ingredients: "Cholate and sugar", description: "", category: category, photo: "https://picsum.photos/id/102/400/300")
  ];
}*/

Future<List<Recipe>> fetchRecipes() async {
  final url = Uri.parse('https://smartfood-api.azurewebsites.net/api/recipes');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((dynamic item) => Recipe.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}

class _RecipesViewState extends State<RecipesView> {
  late Future<List<Recipe>> recipes;

  @override
  void initState() {
    super.initState();
    recipes = fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Recipe>>(
          future: recipes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!
                      .map((Recipe recipe) => RecipeView(recipe: recipe))
                      .toList());
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

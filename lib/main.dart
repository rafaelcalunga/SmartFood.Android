import 'package:flutter/material.dart';
import 'package:smartfood/models/category.dart';
import 'package:smartfood/models/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartFood',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: const RecipesView(title: 'Recipes'),
    );
  }
}

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

List<Recipe> fetchRecipes() {
  const Category category = Category(id: "123", name: "Desserts");

  return [
    const Recipe(id: "123", name: "Banana Cake", preparationTime: 2, servings: 3, ingredients: "Banana and sugar", description: "", category: category, photo: "https://picsum.photos/id/102/400/300"),
    const Recipe(id: "123", name: "Chocolate Cake", preparationTime: 4, servings: 5, ingredients: "Cholate and sugar", description: "", category: category, photo: "https://picsum.photos/id/102/400/300")
  ];
}

class _RecipesViewState extends State<RecipesView> {
  List<Recipe> recipes = [];

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
      body: ListView(
        children: recipes.map((Recipe recipe) => ListTile(
          title: Text(recipe.name),
          subtitle: Text(recipe.category.name),
        )).toList()
      )
    );
  }
}

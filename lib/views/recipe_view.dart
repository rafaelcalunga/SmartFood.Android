import 'package:flutter/material.dart';
import 'package:smartfood/models/recipe.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.recipe.name),
      subtitle: Text(widget.recipe.category.name),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smartfood/models/recipe.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key, required this.recipe, required this.deleteAction}) : super(key: key);

  final Recipe recipe;
  final dynamic deleteAction;

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(widget.recipe.photo)),
        title: Text(widget.recipe.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                Text("${widget.recipe.preparationTime} min"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.restaurant, size: 18),
                Text("${widget.recipe.servings} persons"),
              ],
            ),
            DecoratedBox(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.pink),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(widget.recipe.category.name,
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        trailing:
            TextButton(
              child: const Icon(Icons.remove_circle), 
              onPressed: () {
                 widget.deleteAction(widget.recipe.id);
              }),
      ),
    );
  }
}

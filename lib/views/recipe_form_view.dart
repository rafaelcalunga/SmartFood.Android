import 'package:flutter/material.dart';

class RecipeFormView extends StatefulWidget {
  const RecipeFormView({Key? key}) : super(key: key);

  @override
  State<RecipeFormView> createState() => _RecipeFormViewState();
}

class _RecipeFormViewState extends State<RecipeFormView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Center(
        child: Text('Recipe Form'),
      ),
    );
  }
}
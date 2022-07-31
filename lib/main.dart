import 'package:flutter/material.dart';
import 'package:smartfood/views/recipes_view.dart';

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
        primarySwatch: Colors.pink,
      ),
      home: const RecipesView(title: 'Recipes'),
    );
  }
}


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:smartfood/config/constants.dart';
import 'package:smartfood/models/category.dart';
import 'package:smartfood/models/recipe.dart';

class RecipeFormView extends StatefulWidget {
  const RecipeFormView({Key? key}) : super(key: key);

  @override
  State<RecipeFormView> createState() => _RecipeFormViewState();
}

Future<List<Category>> fetchCategories() async {
  final url = Uri.https(APP_API_URL, '/api/categories');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((dynamic item) => Category.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load ceategories');
  }
}

class _RecipeFormViewState extends State<RecipeFormView> {
  final _formKey = GlobalKey<FormState>();

  late Future<List<Category>> _categories;

  final Recipe _recipe = Recipe(
      id: '',
      name: '',
      preparationTime: 0,
      servings: 0,
      ingredients: '',
      description: '',
      category: Category(id: '', name: ''),
      photo: '');

  @override
  void initState() {
    super.initState();
    _categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null && value.isNotEmpty) {
                        _recipe.name = value;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Preparation time',
                        hintText: 'Time in minutes',
                        suffixIcon: Icon(Icons.access_time)),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preparation time is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null && value.isNotEmpty) {
                        _recipe.preparationTime = int.parse(value);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Servings',
                        suffixIcon: Icon(Icons.restaurant)),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Servings is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null && value.isNotEmpty) {
                        _recipe.servings = int.parse(value);
                      }
                    },
                  ),
                ),
                FutureBuilder<List<Category>>(
                    future: _categories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Category'),
                                items: snapshot.data!
                                    .map(
                                        (Category category) => DropdownMenuItem(
                                              value: category.id,
                                              child: Text(category.name),
                                            ))
                                    .toList(),
                                onChanged: (value) {
                                  print(value);
                                },
                                onSaved: (value) {
                                  if (value != null) {
                                    _recipe.category = snapshot.data!
                                        .firstWhere(
                                            (category) => category.id == value);
                                  }
                                }));
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Category',
                          ),
                          enabled: false,
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null && value.isNotEmpty) {
                        _recipe.description = value;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingredients',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingredients is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null && value.isNotEmpty) {
                        _recipe.ingredients = value;
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      print("LOG: SAVING...");
                      print(_recipe.toJson());

                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Add Recipe'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

Future<bool> postRecipe(Recipe recipe) async {
  final url = Uri.https(APP_API_URL, '/api/recipes');

  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(recipe.toJson()));

  return response.statusCode == 201;
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
      photo: 'https://picsum.photos/400/300');

  @override
  void initState() {
    super.initState();
    _categories = fetchCategories();
  }

  Future<void> _saveRecipeAction() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving...')),
      );
    
      _formKey.currentState!.save();
      var result = await postRecipe(_recipe);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: t.name,
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
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: t.preparationTime,
                        hintText: 'Time in minutes',
                        suffixIcon: const Icon(Icons.access_time)),
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
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: t.servings,
                        suffixIcon: const Icon(Icons.restaurant)),
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
                  onPressed: () async {
                    await _saveRecipeAction();
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

import 'package:flutter/material.dart';
import 'package:fluttered/diet/viewmodel/recipe_viewmodel.dart';

class RecipeView extends StatefulWidget {
  final RecipeViewModel recipe;
  const RecipeView({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.recipe.name);
  }
}

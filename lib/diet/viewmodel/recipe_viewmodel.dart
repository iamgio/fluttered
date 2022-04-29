import 'package:flutter/cupertino.dart';
import 'package:fluttered/diet/model/recipe_model.dart';

class RecipeViewModel {
  String _name = '';
  List<RecipeCategory> _categories = [];
  String? _imageUrl;
  bool _isFavorite = false;
  final VoidCallback? callback;

  RecipeViewModel(RecipeModel recipe, {this.callback}) {
    _name = recipe.name;
    _categories = recipe.categories;
    _imageUrl = recipe.imageUrl;
    _isFavorite = recipe.isFavorite;
  }

  String get name => _name;
  List<RecipeCategory> get categories => _categories;
  String? get imageUrl => _imageUrl;
  bool get isFavorite => _isFavorite;

  set favorite(bool isFavorite) {
    _isFavorite = isFavorite;
    callback?.call();
  }
}

class RecipesViewModel extends ChangeNotifier {
  bool _hasLoaded = false;
  List<RecipeViewModel> _recipes = [];

  RecipesViewModel(Future<RecipesModel> recipesFuture) {
    recipesFuture.then((recipes) {
      _hasLoaded = true;
      _recipes = recipes.recipes.map((recipe) => RecipeViewModel(recipe, callback: () => notifyListeners())).toList();
      notifyListeners();
    });
  }

  bool get hasLoaded => _hasLoaded;
  List<RecipeViewModel> get recipes => _recipes;
  int get length => _recipes.length;
}

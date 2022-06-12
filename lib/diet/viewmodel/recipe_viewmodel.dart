import 'package:flutter/cupertino.dart';
import 'package:fluttered/diet/model/recipe_model.dart';

class RecipeViewModel {
  String _name = '';
  String? _imageUrl;
  bool _isFavorite = false;
  List<String> _tags = [];
  final VoidCallback? callback;

  RecipeViewModel(RecipeModel recipe, {this.callback}) {
    _name = recipe.name;
    _imageUrl = recipe.imageUrl;
    _isFavorite = recipe.isFavorite;
    _tags = recipe.tags;
  }

  String get name => _name;
  String? get imageUrl => _imageUrl;
  bool get isFavorite => _isFavorite;
  List<String> get tags => _tags;

  set isFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
    callback?.call();
  }
}

class RecipesViewModel extends ChangeNotifier {
  bool _hasLoaded = false;
  List<RecipeViewModel> _recipes = [];
  List<String> _tags = [];

  final RecipesFilter filter = RecipesFilter();

  List<RecipeViewModel> _filteredRecipes = []; // _recipes filtered by query, tags, etc by #filter

  RecipesViewModel(Future<RecipesModel> recipesFuture) {
    recipesFuture.then((recipes) {
      _hasLoaded = true;
      _recipes = recipes.recipes.map((recipe) => RecipeViewModel(recipe, callback: () => notifyListeners())).toList();
      _filteredRecipes = _recipes;
      _tags = recipes.tags;
      notifyListeners();
    });
  }

  bool get hasLoaded => _hasLoaded;
  List<RecipeViewModel> get recipes => _recipes;
  List<RecipeViewModel> get filteredRecipes => _filteredRecipes;
  List<String> get tags => _tags;

  void applyFilter(String query) {
    if (query.isEmpty && !filter.onlyFavorites && filter.tagsIndexes.isEmpty) {
      // No filters
      _filteredRecipes = _recipes;
    } else {
      _filteredRecipes = _recipes.where((recipe) {
        return filter.querySatisfied(query, recipe) && (!filter.onlyFavorites || recipe.isFavorite) && filter.tagsSatisfied(recipe.tags, tags);
      }).toList(growable: false);
    }

    notifyListeners();
  }
}

class RecipesFilter {
  final List<int> tagsIndexes = []; // Indexes of active tag filters
  bool onlyFavorites = false;

  bool querySatisfied(String query, RecipeViewModel recipe) {
    return query.isEmpty || recipe.name.toLowerCase().contains(query.toLowerCase()); // TODO ingredients
  }

  bool tagsSatisfied(List<String> recipeTags, List<String> allRecipesTags) {
    return tagsIndexes.every((index) {
      if(index >= allRecipesTags.length) return false;
      return recipeTags.contains(allRecipesTags[index]);
    });
  }
}
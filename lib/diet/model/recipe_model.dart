class RecipeModel {
  final String name;
  final List<RecipeCategory> categories;
  final String? imageUrl;
  final bool isFavorite;

  const RecipeModel({
    required this.name,
    required this.categories,
    required this.imageUrl,
    required this.isFavorite,
  });
}

class RecipesModel {
  final List<RecipeModel> recipes;

  const RecipesModel(this.recipes);
}

enum RecipeCategory {
  breakfast,
  lunch,
  snack,
  dinner,
}

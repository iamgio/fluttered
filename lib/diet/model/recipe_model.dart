class RecipeModel {
  final String name;
  final String? imageUrl;
  final bool isFavorite;
  final List<String> tags;

  const RecipeModel({
    required this.name,
    required this.imageUrl,
    required this.isFavorite,
    required this.tags,
  });
}

class RecipesModel {
  final List<RecipeModel> recipes;
  final List<String> tags;

  const RecipesModel({required this.recipes, required this.tags});
}

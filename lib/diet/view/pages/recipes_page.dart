import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/common/padded_page.dart';
import 'package:fluttered/common/widgets/loading_switcher.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/lang.dart';
import 'package:fluttered/diet/view/recipe_view.dart';
import 'package:fluttered/diet/view/recipes_filter_button.dart';
import 'package:fluttered/diet/viewmodel/recipe_viewmodel.dart';
import 'package:fluttered/diet/widgets/diet_circular_indicator.dart';
import 'package:provider/provider.dart';

class RecipesPage extends StatelessWidget {
  final TextEditingController _queryController = TextEditingController();

  RecipesPage({Key? key}) : super(key: key);

  _buildContent(BuildContext context, RecipesViewModel recipes) {
    return Column(
      children: [
        const SizedBox(height: 8),
        _buildSearchField(),
        _buildSearchFilters(context, recipes),
        const SizedBox(height: 8),
        ...List.generate(recipes.filteredRecipes.length * 2, (index) {
          if (index % 2 != 0) return const SizedBox(height: Const.recipesSpacing);
          return RecipeView(recipe: recipes.filteredRecipes[index ~/ 2]);
        }),
      ],
    );
  }

  _buildInputBorder({double width = Const.recipesSearchDefaultBorderWidth}) => OutlineInputBorder(
        borderSide: BorderSide(color: Const.primary, width: width),
        borderRadius: BorderRadius.circular(Const.recipesSearchRadius),
      );

  _buildSearchField() => TextField(
        controller: _queryController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: lang['search_recipe'],
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: Const.recipesSearchIconPaddingLeft, right: Const.recipesSearchIconPaddingRight),
            child: Icon(CupertinoIcons.search, color: Const.primary),
          ),
          border: _buildInputBorder(),
          enabledBorder: _buildInputBorder(),
          focusedBorder: _buildInputBorder(width: Const.recipesSearchFocusedBorderWidth),
        ),
        cursorColor: Const.primary,
      );

  _buildSearchFilters(BuildContext context, RecipesViewModel recipes) => Padding(
        padding: const EdgeInsets.symmetric(vertical: Const.recipesSpacing),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipesFilterButton(
                child: const Icon(CupertinoIcons.heart_fill, color: Const.secondary),
                onChanged: (changed) {
                  recipes.filter.onlyFavorites = changed;
                  _applyFilter(recipes);
                },
              ),
              ...List.generate(recipes.tags.length * 2, (index) {
                if(index % 2 == 0) return const SizedBox(width: Const.recipesFilterSpacing);
                return RecipesFilterButton(
                  child: Text(recipes.tags[index ~/ 2]),
                  onChanged: (changed) {
                    if (changed) {
                      recipes.filter.tagsIndexes.add(index);
                    } else {
                      recipes.filter.tagsIndexes.remove(index);
                    }
                    _applyFilter(recipes);
                  },
                );
              }),
            ],
          ),
        ),
      );

  void _applyFilter(RecipesViewModel recipes) => recipes.applyFilter(_queryController.text);

  @override
  Widget build(BuildContext context) {
    RecipesViewModel recipes = context.watch<RecipesViewModel>();
    return LoadingSwitcher(
      duration: const Duration(milliseconds: Const.pageSwitchDuration),
      condition: recipes.hasLoaded,
      ifTrue: PaddedPage(child: _buildContent(context, recipes)),
      ifFalse: const DietCircularIndicator(),
    );
  }
}

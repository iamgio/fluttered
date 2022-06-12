import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
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
    return List.generate(recipes.filteredRecipes.length, (index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(Const.defaultPadding, 0, Const.defaultPadding, Const.recipesSpacing),
        child: RecipeView(recipe: recipes.filteredRecipes[index]),
      );
    });
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

  // A gradient masks for the scrollable filters row
  _buildFiltersScrollGradient() => Positioned.fill(
    child: IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Const.tertiary,
              Const.tertiary.withOpacity(0),
              Const.tertiary.withOpacity(0),
              Const.tertiary,
            ],
            stops: const [0, Const.recipesFilterScrollGradientOffset, 1 - Const.recipesFilterScrollGradientOffset, 1],
          ),
        ),
      ),
    ),
  );

  _buildSearchFilters(BuildContext context, RecipesViewModel recipes) => Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: Const.defaultPadding),
                RecipesFilterButton(
                  child: const Icon(CupertinoIcons.heart_fill, color: Const.secondary),
                  onChanged: (changed) {
                    recipes.filter.onlyFavorites = changed;
                    _applyFilter(recipes);
                  },
                ),
                ...List.generate(recipes.tags.length * 2, (index) {
                  if (index % 2 == 0) return const SizedBox(width: Const.recipesFilterSpacing);
                  int i = index ~/ 2;
                  return RecipesFilterButton(
                    child: Text(recipes.tags[i]),
                    onChanged: (changed) {
                      if (changed) {
                        recipes.filter.tagsIndexes.add(i);
                      } else {
                        recipes.filter.tagsIndexes.remove(i);
                      }
                      _applyFilter(recipes);
                    },
                  );
                }),
                const SizedBox(width: Const.defaultPadding),
              ],
            ),
          ),
          _buildFiltersScrollGradient(),
        ],
      );

  _buildSearchFiltersBar(BuildContext context, RecipesViewModel recipes) {
    return Container(
      color: Const.tertiary,
      child: Column(
        children: [
          const SizedBox(height: Const.recipesSpacing / 2),
          _buildSearchFilters(context, recipes),
          const SizedBox(height: Const.recipesSpacing),
        ],
      ),
    );
  }

  void _applyFilter(RecipesViewModel recipes) => recipes.applyFilter(_queryController.text);

  @override
  Widget build(BuildContext context) {
    RecipesViewModel recipes = context.watch<RecipesViewModel>();
    return LoadingSwitcher(
      duration: const Duration(milliseconds: Const.pageSwitchDuration),
      condition: recipes.hasLoaded,
      ifTrue: CustomScrollView(
        slivers: [
          // When scrolling, the search bar gets hidden
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                Const.defaultPadding,
                8,
                Const.defaultPadding,
                Const.recipesSpacing / 2,
              ),
              child: _buildSearchField(),
            ),
          ),
          // The search filters stay on instead
          SliverStickyHeader(
            header: _buildSearchFiltersBar(context, recipes),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                ..._buildContent(context, recipes), // Recipe widgets are built here
              ]),
            ),
          ),
        ],
      ),
      ifFalse: const DietCircularIndicator(),
    );
  }
}

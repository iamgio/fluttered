import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/common/padded_page.dart';
import 'package:fluttered/common/widgets/loading_switcher.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/lang.dart';
import 'package:fluttered/diet/view/recipe_view.dart';
import 'package:fluttered/diet/viewmodel/recipe_viewmodel.dart';
import 'package:fluttered/diet/widgets/diet_circular_indicator.dart';
import 'package:provider/provider.dart';

class RecipesPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  RecipesPage({Key? key}) : super(key: key);

  _buildContent(RecipesViewModel recipes) {
    return Column(
      children: [
        const SizedBox(height: 8),
        _buildSearchField(),
        const SizedBox(height: Const.recipesSpacing),
        ...List.generate(recipes.length * 2, (index) {
          if (index % 2 == 0) return const SizedBox(height: Const.recipesSpacing);
          return RecipeView(recipe: recipes.recipes[index ~/ 2]);
        }),
      ],
    );
  }

  _buildInputBorder({double width = Const.recipesSearchDefaultBorderWidth}) => OutlineInputBorder(
    borderSide: BorderSide(color: Const.primary, width: width),
    borderRadius: BorderRadius.circular(Const.recipesSearchRadius),
  );

  _buildSearchField() => TextField(
    controller: _controller,
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

  @override
  Widget build(BuildContext context) {
    RecipesViewModel recipes = context.watch<RecipesViewModel>();
    return LoadingSwitcher(
      duration: const Duration(milliseconds: Const.pageSwitchDuration),
      condition: recipes.hasLoaded,
      ifTrue: PaddedPage(child: _buildContent(recipes)),
      ifFalse: const DietCircularIndicator(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:fluttered/common/padded_page.dart';
import 'package:fluttered/common/widgets/loading_switcher.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/view/recipe_view.dart';
import 'package:fluttered/diet/viewmodel/recipe_viewmodel.dart';
import 'package:fluttered/diet/widgets/diet_circular_indicator.dart';
import 'package:provider/provider.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({Key? key}) : super(key: key);

  _buildContent(RecipesViewModel recipes) {
    return Column(
      children: List.generate(recipes.length * 2, (index) {
        if (index % 2 == 0) return const SizedBox(height: Const.recipesSpacing);
        return RecipeView(recipe: recipes.recipes[index ~/ 2]);
      }),
    );
  }

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

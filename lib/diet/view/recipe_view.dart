import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/viewmodel/recipe_viewmodel.dart';
import 'package:simple_animations/simple_animations.dart';

class RecipeView extends StatefulWidget {
  final RecipeViewModel recipe;
  const RecipeView({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> with AnimationMixin {
  late Animation<double> _heartSize;

  @override
  void initState() {
    _heartSize = Tween(begin: 1.0, end: Const.recipeHeartAnimationScale).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutSine,
      reverseCurve: Curves.easeInQuart,
    ));
    super.initState();
  }

  LinearGradient _buildGradient() => LinearGradient(
        colors: [
          Colors.transparent,
          Colors.black.withOpacity(Const.recipeGradientOpacity),
        ],
        stops: Const.recipeGradientStops,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Const.primary.withOpacity(Const.recipeShadowOpacity),
            offset: const Offset(0, Const.recipeShadowY),
            blurRadius: Const.recipeRadius,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Const.recipeRadius),
        child: Stack(
          children: [
            Container(
              // Image background
              width: double.infinity,
              height: Const.recipeHeight,
              child: recipe.imageUrl != null ? Image.network(recipe.imageUrl!, fit: BoxFit.cover) : null,
              color: Colors.black54,
            ),
            if (recipe.imageUrl != null)
              Container(
                // Black gradient for increased contrast
                width: double.infinity,
                height: Const.recipeHeight,
                decoration: BoxDecoration(gradient: _buildGradient()),
              ),
            Padding(
              padding: const EdgeInsets.all(Const.recipesSpacing),
              child: Text(recipe.name, style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white, height: Const.lineHeight)),
            ),
            Positioned(
              right: Const.recipesSpacing,
              bottom: Const.recipesSpacing,
              child: FloatingActionButton(
                backgroundColor: Const.secondary,
                child: ScaleTransition(
                  scale: _heartSize,
                  child: Icon(recipe.isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart),
                ),
                onPressed: () {
                  controller.play(duration: const Duration(milliseconds: Const.recipeHeartAnimationDuration)).then((_) => controller.reverse());
                  recipe.isFavorite ^= true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

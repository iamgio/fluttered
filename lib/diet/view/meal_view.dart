import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/viewmodel/meal_food_viewmodel.dart';
import 'package:fluttered/diet/viewmodel/meal_viewmodel.dart';

class MealView extends StatelessWidget {
  final MealViewModel meal;
  const MealView({Key? key, required this.meal}) : super(key: key);

  _buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.all(Const.defaultPadding),
        decoration: const BoxDecoration(
          color: Const.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Const.mealRadius),
            topRight: Radius.circular(Const.mealRadius),
            bottomLeft: Radius.zero,
            bottomRight: Radius.circular(Const.mealRadius),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: Const.mealAdditionalLeftPadding),
            Text(
              meal.name,
              style: Theme.of(context).textTheme.headline2!.copyWith(color: Const.tertiary),
            ),
            const Spacer(),
            const Icon(CupertinoIcons.right_chevron, color: Const.tertiary),
          ],
        ),
      );

  _buildFoodView(BuildContext context, MealFoodViewModel food) => ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: Const.mealVerticalPadding, horizontal: Const.defaultPadding + Const.mealAdditionalLeftPadding),
        minLeadingWidth: Const.mealSpacing,
        leading: Container(
          width: Const.mealImageSize,
          height: Const.mealImageSize,
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(Const.mealImageRadius)),
          ),
          child: food.imageUrl != null ? Image.network(food.imageUrl!) : null,
        ),
        title: Text(food.name, style: Theme.of(context).textTheme.headline3),
        subtitle: Text(food.stringAmount, style: Theme.of(context).textTheme.bodyText2),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(Const.mealRadius)),
        boxShadow: [
          BoxShadow(
            color: Const.primary.withOpacity(Const.mealShadowOpacity),
            blurRadius: Const.mealShadowBlur,
            offset: const Offset(0, Const.mealShadowY),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          ...List.generate(meal.foods.length * 2 - 1, (index) {
            if (index % 2 != 0) return const Divider(height: 0);
            return _buildFoodView(context, meal.foods[index ~/ 2]);
          }),
        ],
      ),
    );
  }
}

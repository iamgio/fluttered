import 'package:fluttered/diet/model/meal_food_model.dart';

class MealModel {
  final String name;
  final List<MealFoodModel> foods;

  const MealModel({required this.name, required this.foods});
}
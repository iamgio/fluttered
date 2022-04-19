import 'package:fluttered/diet/model/meal_model.dart';
import 'package:fluttered/diet/viewmodel/meal_food_viewmodel.dart';

class MealViewModel {
  String _name = '';
  List<MealFoodViewModel> _foods = [];

  MealViewModel(MealModel meal) {
    _name = meal.name;
    _foods = meal.foods.map((food) => MealFoodViewModel(food)).toList();
  }

  String get name => _name;
  List<MealFoodViewModel> get foods => _foods;
}
import 'package:flutter/cupertino.dart';
import 'package:fluttered/diet/model/diet_model.dart';
import 'package:fluttered/diet/viewmodel/meal_viewmodel.dart';

class DailyDietViewModel {
  int _day = -1;
  List<MealViewModel> _meals = [];
  final VoidCallback? callback;

  DailyDietViewModel(DailyDietModel dailyDiet, {this.callback}) {
    _day = dailyDiet.day;
    _meals = dailyDiet.meals.map((meal) => MealViewModel(meal)).toList();
  }

  int get day => _day;

  List<MealViewModel> get meals => _meals;
  // Support editing in the future
}

class WeeklyDietViewModel {
  List<DailyDietViewModel> _dailyDiets = [];
  final VoidCallback? callback;

  WeeklyDietViewModel(WeeklyDietModel weeklyDiet, {this.callback}) {
    _dailyDiets = weeklyDiet.dailyDiets.map((diet) => DailyDietViewModel(diet, callback: callback)).toList();
  }

  List<DailyDietViewModel> get dailyDiets => _dailyDiets;
}
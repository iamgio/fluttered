import 'package:flutter/cupertino.dart';
import 'package:fluttered/diet/model/diet_model.dart';
import 'package:fluttered/diet/model/meal_model.dart';

class DailyDietViewModel {
  int _day = -1;
  List<MealModel> _meals = [];
  final VoidCallback? callback;

  DailyDietViewModel(DailyDietModel dailyDiet, {this.callback}) {
    _day = dailyDiet.day;
    _meals = dailyDiet.meals;
  }

  int get day => _day;

  List<MealModel> get meals => _meals;
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
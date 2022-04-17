import 'package:fluttered/diet/model/meal_model.dart';

class DailyDietModel {
  final int day; // 0-6
  final List<MealModel> meals;

  DailyDietModel({required this.day, required this.meals});
}

class WeeklyDietModel {
  final List<DailyDietModel> dailyDiets;

  WeeklyDietModel({required this.dailyDiets});
}
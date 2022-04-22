import 'package:fluttered/diet/model/meal_model.dart';

class DailyDietModel {
  final int day; // 0-6
  final List<MealModel> meals;

  const DailyDietModel({required this.day, required this.meals});
}

class WeeklyDietModel {
  final List<DailyDietModel> dailyDiets;

  const WeeklyDietModel({required this.dailyDiets});
}
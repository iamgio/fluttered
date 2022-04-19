// This file contains pre-made data.
// In a regular application, these should be fetched via HTTP calls.

// ignore_for_file: non_constant_identifier_names

import 'package:fluttered/diet/model/diet_model.dart';
import 'package:fluttered/diet/model/meal_food_model.dart';
import 'package:fluttered/diet/model/meal_model.dart';
import 'package:fluttered/diet/model/user_model.dart';

Future<UserModel> data_getUser() => Future.delayed(
      const Duration(seconds: 1),
      () => UserModel(
        name: 'Giorgio',
        weeklyDiet: WeeklyDietModel(
          dailyDiets: [
            DailyDietModel(day: 0, meals: [
              MealModel(name: 'Meal 1', foods: [
                MealFoodModel(
                  name: 'Food 1',
                  amount: 50,
                ),
                MealFoodModel(
                  name: 'Food 2',
                  amount: 3,
                  quantityType: QuantityType.pieces,
                ),
              ]),
              MealModel(name: 'Meal 2', foods: [
                MealFoodModel(
                  name: 'Food 3',
                  amount: 3,
                  quantityType: QuantityType.pieces,
                ),
              ]),
            ]),
            DailyDietModel(day: 1, meals: [
              MealModel(name: 'Meal 1', foods: []),
            ]),
          ],
        ),
      ),
    );

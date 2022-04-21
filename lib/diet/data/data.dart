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
              MealModel(name: 'Breakfast', foods: [
                MealFoodModel(
                  name: 'Cereals',
                  amount: 20,
                ),
                MealFoodModel(
                  name: 'Dark Chocolate',
                  amount: 10,
                  quantityType: QuantityType.grams,
                ),
                MealFoodModel(
                  name: 'Milk',
                  amount: 200,
                  quantityType: QuantityType.grams,
                ),
              ]),
              MealModel(name: 'Lunch', foods: [
                MealFoodModel(
                  name: 'Pasta',
                  amount: 80,
                  quantityType: QuantityType.grams,
                ),
                MealFoodModel(
                  name: 'Apple',
                  amount: 1,
                  quantityType: QuantityType.pieces,
                ),
              ]),
              MealModel(name: 'test', foods: []),
            ]),
            DailyDietModel(day: 1, meals: [
              MealModel(name: 'Meal 1', foods: []),
            ]),
          ],
        ),
      ),
    );

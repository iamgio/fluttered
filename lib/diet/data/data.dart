// This file contains pre-made data.
// In a regular application, these should be fetched via HTTP calls.

// ignore_for_file: non_constant_identifier_names

import 'package:fluttered/diet/model/diet_model.dart';
import 'package:fluttered/diet/model/meal_food_model.dart';
import 'package:fluttered/diet/model/meal_model.dart';
import 'package:fluttered/diet/model/recipe_model.dart';
import 'package:fluttered/diet/model/user_model.dart';

Future<UserModel> data_getUser() => Future.delayed(
      const Duration(seconds: 1),
      () => const UserModel(
        name: 'Giorgio',
        weeklyDiet: WeeklyDietModel(
          dailyDiets: [
            DailyDietModel(day: 0, meals: [
              MealModel(name: 'Breakfast', foods: [
                MealFoodModel(
                  name: 'Cereals',
                  amount: 20,
                  imageUrl: 'https://i.imgur.com/leeOxMI.png',
                ),
                MealFoodModel(
                  name: 'Dark Chocolate',
                  amount: 10,
                  quantityType: QuantityType.grams,
                  imageUrl: 'https://i.imgur.com/rXfQdse.png',
                ),
                MealFoodModel(
                  name: 'Milk',
                  amount: 200,
                  quantityType: QuantityType.grams,
                  imageUrl: 'https://i.imgur.com/xgLg5AK.png',
                ),
              ]),
              MealModel(name: 'Lunch', foods: [
                MealFoodModel(
                  name: 'Pasta',
                  amount: 80,
                  quantityType: QuantityType.grams,
                  imageUrl: 'https://i.imgur.com/oVdto9M.png',
                ),
                MealFoodModel(
                  name: 'Apple',
                  amount: 1,
                  quantityType: QuantityType.pieces,
                  imageUrl: 'https://i.imgur.com/J7KsDGD.png',
                ),
              ]),
            ]),
            DailyDietModel(day: 1, meals: [
              MealModel(name: 'Meal 1', foods: []),
            ]),
            DailyDietModel(day: 1, meals: [
              MealModel(name: 'Meal 1', foods: []),
            ]),
            DailyDietModel(day: 0, meals: [
              MealModel(name: 'Breakfast', foods: [
                MealFoodModel(
                  name: 'Orange Juice',
                  amount: 80,
                ),
                MealFoodModel(
                  name: 'Yogurt',
                  amount: 150,
                  quantityType: QuantityType.grams,
                ),
              ]),
              MealModel(name: 'Lunch', foods: [
                MealFoodModel(
                  name: 'Chicken Breast',
                  amount: 120,
                  quantityType: QuantityType.grams,
                ),
                MealFoodModel(
                  name: 'Lettuce',
                  amount: 50,
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

Future<RecipesModel> data_getRecipes() => Future.delayed(
  const Duration(seconds: 1),
    () => const RecipesModel([
      RecipeModel(name: 'Recipe 1', categories: [], imageUrl: null, isFavorite: false),
      RecipeModel(name: 'Recipe 2', categories: [], imageUrl: null, isFavorite: false),
    ]),
);
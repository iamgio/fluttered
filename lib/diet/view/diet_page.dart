import 'package:flutter/cupertino.dart';
import 'package:fluttered/diet/view/meal_view.dart';
import 'package:fluttered/diet/view/padded_page.dart';
import 'package:fluttered/diet/viewmodel/diet_viewmodel.dart';

class DietPage extends StatelessWidget {
  final WeeklyDietViewModel weeklyDiet;
  const DietPage({Key? key, required this.weeklyDiet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddedPage(
      child: Column(
        children: [
          MealView(meal: weeklyDiet.dailyDiets.first.meals.first),
        ],
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/view/meal_view.dart';
import 'package:fluttered/diet/viewmodel/diet_viewmodel.dart';

class DietPage extends StatefulWidget {
  final WeeklyDietViewModel weeklyDiet;
  const DietPage({Key? key, required this.weeklyDiet}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  int _selectedIndex = 0; // TODO current day of week
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }


  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  List<Widget> _buildDailyMeals(int day) {
    final daily = widget.weeklyDiet.dailyDiets;
    if(day < 0 || day >= daily.length) return [];
    final meals = daily[day].meals;
    return meals.map((meal) => Padding(
      padding: const EdgeInsets.all(Const.defaultPadding),
      child: MealView(meal: meal),
    )).toList();
  }

  _buildWeeklyMeals() => List.generate(7, (index) => Column(
    children: _buildDailyMeals(index),
  ));

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController!,
      onPageChanged: (index) {
        setState(() => _selectedIndex = index);
      },
      children: _buildWeeklyMeals(),
    );
  }
}

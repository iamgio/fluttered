import 'package:flutter/cupertino.dart';
import 'package:fluttered/diet/constants.dart';
import 'package:fluttered/diet/view/horizontal_day_picker.dart';
import 'package:fluttered/diet/view/meal_view.dart';
import 'package:fluttered/diet/viewmodel/diet_viewmodel.dart';

class DietPage extends StatefulWidget {
  final WeeklyDietViewModel weeklyDiet;
  const DietPage({Key? key, required this.weeklyDiet}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  int _selectedDay = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now().weekday - 1;
    _pageController = PageController();
    Future.microtask(() => _switchTo(_selectedDay, animate: false));
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  _switchTo(int day, {bool animate = true}) {
    if(!animate) {
      _pageController?.jumpToPage(day);
      return;
    }
    _pageController?.animateToPage(
      day,
      duration: const Duration(milliseconds: Const.pageSwitchDuration),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> _buildDailyMeals(int day) {
    final daily = widget.weeklyDiet.dailyDiets;
    if (day < 0 || day >= daily.length) return [];
    final meals = daily[day].meals;
    return meals
        .map((meal) => Padding(
              padding: const EdgeInsets.all(Const.defaultPadding),
              child: MealView(meal: meal),
            ))
        .toList();
  }

  _buildWeeklyMeals() => List.generate(7, (index) => ListView(children: _buildDailyMeals(index)));

  _buildDayPicker() => HorizontalDayPicker(
      selectedDay: _selectedDay,
      onSelect: (day) {
        _selectedDay = day;
        _switchTo(day);
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDayPicker(),
        Expanded(
          child: PageView(
            controller: _pageController!,
            onPageChanged: (day) {
              setState(() => _selectedDay = day);
            },
            children: _buildWeeklyMeals(),
          ),
        ),
      ],
    );
  }
}

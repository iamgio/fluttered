import 'package:fluttered/diet/model/diet_model.dart';

class UserModel {
  final String name;
  final WeeklyDietModel weeklyDiet;

  const UserModel({required this.name, required this.weeklyDiet});
}
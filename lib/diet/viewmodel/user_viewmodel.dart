import 'package:flutter/material.dart';
import 'package:fluttered/diet/model/diet_model.dart';
import 'package:fluttered/diet/model/user_model.dart';
import 'package:fluttered/diet/viewmodel/diet_viewmodel.dart';

class UserViewModel extends ChangeNotifier {
  bool _hasLoaded = false;
  String _name = '';
  WeeklyDietViewModel _weeklyDiet = WeeklyDietViewModel(WeeklyDietModel(dailyDiets: []));

  UserViewModel(Future<UserModel> userFuture) {
    userFuture.then((user) {
      _hasLoaded = true;
      _name = user.name;
      _weeklyDiet = WeeklyDietViewModel(user.weeklyDiet);
      notifyListeners();
    });
  }

  bool get hasLoaded => _hasLoaded;
  String get name => _name;
  WeeklyDietViewModel get weeklyDiet => _weeklyDiet;
}

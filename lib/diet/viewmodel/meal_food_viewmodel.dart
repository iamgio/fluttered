import 'package:fluttered/diet/model/meal_food_model.dart';

class MealFoodViewModel {
  String _name = '';
  int _amount = -1;
  QuantityType _quantityType = QuantityType.undefined;
  String? _imageUrl;

  MealFoodViewModel(MealFoodModel food) {
    _name = food.name;
    _amount = food.amount;
    _quantityType = food.quantityType;
    _imageUrl = food.imageUrl;
  }

  String get name => _name;
  int get amount => _amount;
  QuantityType get quantityType => _quantityType;
  String get stringAmount => _amount.toString() + _quantityType.asString(_amount);
  String? get imageUrl => _imageUrl;
}
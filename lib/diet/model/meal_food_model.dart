class MealFoodModel {
  final String name;
  final int amount;
  final QuantityType quantityType;
  final String? imageUrl;

  MealFoodModel({required this.name, required this.amount, this.quantityType = QuantityType.grams, this.imageUrl});
}

enum QuantityType {
  undefined, grams, pieces
}

extension QuantityTypeExtension on QuantityType {
  String asString(int? amount) {
    switch(this) {
      case QuantityType.undefined:
        return '';
      case QuantityType.grams:
        return 'g';
      case QuantityType.pieces:
        return ' piece' + (amount == null ? '(s)' : amount == 1 ? '' : 's');
    }
  }
}
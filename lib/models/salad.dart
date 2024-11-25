import 'package:food_delivery/models/ingredient.dart';

import 'package:food_delivery/models/enums.dart';

import 'food.dart';

class Salad extends Food {
  Salad({
    required String name,
    required double price,
    required String description,
    required String miniDescription,
    required String image,
    required FoodCategory category,
    required List<Ingredient> ingredients,
    required bool isPopular,
  }) : super(
          name: name,
          price: price,
          description: description,
          miniDescription: miniDescription,
          image: image,
          foodType: FoodType.salad,
          category: category,
          ingredients: ingredients,
          isPopular: isPopular,
        );
}

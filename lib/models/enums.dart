enum FoodType {
  pizza,
  burger,
  fries,
  salad,
  dessert,
  drink,
  cocktail,
}

//get "FoodType.pizza", -> return "pizza"
String getFoodType(FoodType type) => type.toString().substring(9);


//FILTERS

enum FoodCategory {
  vegetarian,
  vegan,
  normal,
}

enum BurgerMeatType {
  beef,
  chicken,
  fish,
  vegetarian,
}

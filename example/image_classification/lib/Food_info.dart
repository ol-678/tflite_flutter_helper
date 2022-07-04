//FoodInfo is an information container.
//If any nutritional data about a food type is requested,
// it is always given back as a FoodInfo object.

class FoodInfo{
  String name;
  int calories;
  int sodium;
  double sugar;
  int cholesterol;
  int carbohydrates;

  FoodInfo(
      this.name,
      this.calories,
      this.sodium,
      this.sugar,
      this.cholesterol,
      this.carbohydrates,
      );
}


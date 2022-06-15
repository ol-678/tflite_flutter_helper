import 'Food_info.dart';

class Food_Dictionary
{
  static Map < String, FoodInfo > AllFoods =
  {
    "lettuce": FoodInfo ("Lettuce", 5, 10, 0.3, 0, 1),
    'Cooked_chicken': FoodInfo ("Cooked Chicken", 335, 115, 0, 123, 0),
    'milk': FoodInfo("Milk", 124, 116, 12, 20, 12),
    'bread': FoodInfo("Bread", 79, 147, 1.5, 0, 15),
    "Ice_Cream": FoodInfo("Ice Cream", 137, 53, 14, 29, 16),
    "Apples": FoodInfo("Apples", 95, 2, 19, 0, 25),
    "Chocolate": FoodInfo("Dark Chocolate", 155, 7, 14, 2, 17),
    "Fish": FoodInfo("Salmon", 366, 109, 0, 112, 0),
    "Oranges": FoodInfo("Oranges", 45, 0, 9, 0, 11),
    "Coffee": FoodInfo("Coffee (black)", 1, 5, 0, 0, 0)
  };
}
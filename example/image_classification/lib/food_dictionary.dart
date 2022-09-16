import 'Food_info.dart';

//Food_Dictionary contains a static dictionary that several screens use to
//turn a basic string into usable information about food.
//Food information is hard-coded into this application.
class Food_Dictionary
{
  static Map < String, FoodInfo > AllFoods =
  {
    "Lettuce": FoodInfo ("Lettuce", 5, 10, 0.3, 0, 1),
    'Cooked Chicken': FoodInfo ("Cooked Chicken", 335, 115, 0, 123, 0),
    'Milk': FoodInfo("Milk", 124, 116, 12, 20, 12),
    'Bread': FoodInfo("Bread", 79, 147, 1.5, 0, 15),
    "Ice Cream": FoodInfo("Ice Cream", 137, 53, 14, 29, 16),
    "Apple": FoodInfo("Apple", 95, 2, 19, 0, 25),
    "Chocolate": FoodInfo("Chocolate", 155, 7, 14, 2, 17),
    "Fish": FoodInfo("Fish", 366, 109, 0, 112, 0),
    "Orange": FoodInfo("Orange", 45, 0, 9, 0, 11),
    "Coffee": FoodInfo("Coffee", 1, 5, 0, 0, 0),
    "Seafood": FoodInfo("Seafood", 110, 130, 0, 43, 1)
  };
}
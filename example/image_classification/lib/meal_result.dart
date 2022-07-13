import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Food_info.dart';
import 'dashboard_screen.dart';
import 'food_dictionary.dart';

class MealResult extends StatefulWidget {
  //the name of the desired meal to look up in SharedPreferences.
  final String mealID;
  const MealResult({Key? key, required this.mealID}) : super(key: key);

  @override
  State<MealResult> createState() => _MealResultState();
}

class _MealResultState extends State<MealResult> {
  //A list of food names grabbed from SharedPreferences.
  List<String> loadedMealNames = [];

  //The list of food names, now formatted as their corresponding FoodInfos.
  List<FoodInfo> mealInfo = [];

  //adds up all calories from the foods in mealInfo
  int getCalorieTotal()
  {
    int counter = 0;
    for(FoodInfo f in mealInfo){
      counter+=f.calories;
    }
    return counter;
  }

  //adds up all carbs from the foods in mealInfo
  int getCarbsTotal()
  {
    int counter = 0;
    for(FoodInfo f in mealInfo){
      counter+=f.carbohydrates;
    }
    return counter;
  }

  //adds up all sugar from the foods in mealInfo
  double getSugarTotal()
  {
    double counter = 0;
    for(FoodInfo f in mealInfo){
      counter+=f.sugar;
    }
    return counter;
  }

  //adds up all sodium from the foods in mealInfo
  int getSodiumTotal()
  {
    int counter = 0;
    for(FoodInfo f in mealInfo){
      counter+=f.sodium;
    }
    return counter;
  }

  //adds up all cholesterol from the foods in mealInfo
  int getCholesterolTotal()
  {
    int counter = 0;
    for(FoodInfo f in mealInfo){
      counter+=f.cholesterol;
    }
    return counter;
  }

  //Updates averages within SharedPreferences
  //These are shown on the dashboard page
  Future <void> SaveData ()async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    //get the amount of meals eaten
    int mealsEaten = 0;
    int? grabbedMeals = prefs.getInt("meals");
    if (grabbedMeals != null)
    {
      mealsEaten = grabbedMeals;
    }

    //increase by one (include this meal)
    mealsEaten += 1;

    //average calories
    int totalCal = getCalorieTotal();
    int? lifetimeCal = prefs.getInt("lifetimeCalories");
    if (lifetimeCal != null)
    {
      totalCal += lifetimeCal;
    }
    await prefs.setInt("lifetimeCalories", totalCal);

    //average carbohydrates
    int totalCarbs = getCarbsTotal();
    int? lifetimeCarbs = prefs.getInt("lifetimeCarbohydrates");
    if (lifetimeCarbs != null)
    {
      totalCarbs += lifetimeCarbs;
    }
    await prefs.setInt("lifetimeCarbohydrates", totalCarbs);

    //average sugar
    double totalSugar = getSugarTotal();
    double? lifetimeSugar = prefs.getDouble("lifetimeSugar");
    if (lifetimeSugar != null)
    {
      totalSugar += lifetimeSugar;
    }
    await prefs.setDouble("lifetimeSugar", totalSugar);

    //average sodium
    int totalSodium = getSodiumTotal();
    int? lifetimeSodium = prefs.getInt("lifetimeSodium");
    if (lifetimeSodium != null)
    {
      totalSodium += lifetimeSodium;
    }
    await prefs.setInt("lifetimeSodium", totalSodium);

    //average cholesterol
    int totalCholesterol = getCholesterolTotal();
    int? lifetimeCholesterol = prefs.getInt("lifetimeCholesterol");
    if (lifetimeCholesterol != null)
    {
      totalCholesterol += lifetimeCholesterol;
    }
    await prefs.setInt("lifetimeCholesterol", totalCholesterol);
  }

  // Retrieve the saved name if it exists
  @override
  void initState() {
    super.initState();
    _retreiveFoodInfo(); //set meals list
    SaveData();
  }
  Future<void> _retreiveFoodInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.mealID)){
      setState(() {
        loadedMealNames = prefs.getStringList(widget.mealID)!;
        for(String s in loadedMealNames)
        {
          mealInfo.add(getCorrespondingFood(s));
        }
      });
    }
  }
  FoodInfo getCorrespondingFood (String foodName) {
    switch (foodName) {
      case "Apple":
        return Food_Dictionary.AllFoods["Apple"]!;
      case "Bread":
        return Food_Dictionary.AllFoods['Bread']!;
      case "Chocolate":
        return Food_Dictionary.AllFoods['Chocolate']!;
      case "Coffee":
        return Food_Dictionary.AllFoods['Coffee']!;
      case "Cooked Chicken":
        return Food_Dictionary.AllFoods['Cooked Chicken']!;
      case "Ice Cream":
        return Food_Dictionary.AllFoods['Ice Cream']!;
      case "Lettuce":
        return Food_Dictionary.AllFoods['Lettuce']!;
      case "Milk":
        return Food_Dictionary.AllFoods['Milk']!;
      case "Orange":
        return Food_Dictionary.AllFoods['Orange']!;
      case "Seafood":
        return Food_Dictionary.AllFoods['Seafood']!;
      default:
        return FoodInfo("null", 0, 0, 0, 0, 0);;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Result"),),
      body: Center(
        child: Column (
          children: [
            Expanded(
              flex: 60,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: mealInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Text(mealInfo [index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                        Text("calories: " + mealInfo [index].calories.toString() + ' kcal',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("carbohydrates: " + mealInfo [index].carbohydrates.toString() + ' grams'),
                        Text("cholesterol: " + mealInfo [index].cholesterol.toString() + ' miligrams'),
                        Text("sodium: " + mealInfo [index].sodium.toString() + ' miligrams'),
                        Text("sugar: " + mealInfo [index].sugar.toString() + ' grams'),
                      ]
                    )
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            ),
            Text("Total number of calories: " + getCalorieTotal().toString() + ' kcal'),
          ]
        )
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        },
        child: Icon (
          Icons.house
        )
      )
    );

  }
}

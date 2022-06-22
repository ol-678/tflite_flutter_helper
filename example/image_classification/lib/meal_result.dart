import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Food_info.dart';
import 'food_dictionary.dart';

class MealResult extends StatefulWidget {
  final String mealID;
  const MealResult({Key? key, required this.mealID}) : super(key: key);

  @override
  State<MealResult> createState() => _MealResultState();
}

class _MealResultState extends State<MealResult> {
  List<String> loadedMealNames = [];
  List<FoodInfo> mealInfo = [];
  int getCalorieTotal()
  {
    int counter = 0;
    for(FoodInfo f in mealInfo){
      counter+=f.calories;
    }
    return counter;
  }
  // Retrieve the saved name if it exists
  @override
  void initState() {
    super.initState();
    _retreiveFoodInfo(); //set meals list
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
    );

  }
}

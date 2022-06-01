import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Food_info.dart';

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
      case "lettuce":
        return FoodInfo("lettuce", 5, 10, 0.3, 0, 1);
      case "Chicken":
        return FoodInfo("Chicken", 335, 115, 0, 123, 0);
      case "milk":
        return FoodInfo("milk", 124, 116, 12, 20, 12);
      case "bread":
        return FoodInfo("bread", 79, 147, 1.5, 0, 15);
      case "Ice cream":
        return FoodInfo("Ice cream", 137, 53, 14, 29, 16);
      default:
        return FoodInfo("null", 0, 0, 0, 0, 0);
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

import 'package:flutter/material.dart';
import 'package:imageclassification/classification.dart';
import 'package:imageclassification/meal_result.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Food_info.dart';

//RecordedData is a static class containing a list of FoodInfo
//pertaining to the user's current meal, as well as the meal type
//When a meal is reset or submitted, RecordedData is cleared
//In other words, RecordedData will never accidentally store information
//between sessions/meals
class RecordedData {
  //What time was the meal eaten? (e.g: breakfast, lunch, etc)
  static String typeOfMeal = "";

  //a list of foods eaten for this meal
  static List<FoodInfo> foods = <FoodInfo>[];

  static void removeFood(int index){
    foods.removeAt(index);
  }

  //turns FoodInfo list into a list of only strings
  //this is so it can be saved in SharedPreferences
  static List<String> generateFoodNames(){
    List<String> resultList = <String>[];
    for (FoodInfo f in foods) {
      resultList.add(f.name);
    }
    return resultList;
  }
}

class MealGeneration extends StatefulWidget {
  const MealGeneration({Key? key}) : super(key: key);

  @override
  State<MealGeneration> createState() => _MealGenerationState();
}

class _MealGenerationState extends State<MealGeneration> {

  //Creates a name for this meal, including type and timestamp
  String generateMealName () {
    String todaysDate = DateFormat("MM-dd-yyyy").format(DateTime.now());
    return todaysDate + ' ' + RecordedData.typeOfMeal;
  }

  //saves the contents of the meal (list of strings) into SharedPreferences
  //the meal is saved as a list of strings
  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    String foodNameList = generateMealName();
    List<String> names = RecordedData.generateFoodNames();
    prefs.setStringList(foodNameList, names);
  }

  //saves meal into SharedPreferences and goes to MealResult
  //the name of the meal within SharedPreferences is passed onto this new screen
  Future<void> _saveMeal() async{
    await _saveName();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealResult(mealID: generateMealName(),)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(RecordedData.typeOfMeal),),
      body: Center(
        child: Container (
          child:
            ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: RecordedData.foods.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 50,
                    color: Colors.amber[500],
                    child: Text(RecordedData.foods[index].name,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent[700],
                    ))
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            )
        ),
        ),

        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
            right: 10,
            bottom: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Classification()),
                    );
                  },
                  tooltip: 'Pick Image',
                    child: Icon(Icons.add_a_photo),
                  ),
                if (RecordedData.foods.length > 0)
                FloatingActionButton(
                  heroTag: null,
                  onPressed: _saveMeal,
                  child: Icon(Icons.check),
                ),
              ],
            ),
          ),
         ],
        ),
    );

  }
}



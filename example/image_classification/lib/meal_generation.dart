import 'package:flutter/material.dart';
import 'package:imageclassification/meal_result.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Food_info.dart';
import 'main.dart';

class RecordedData {
  static String typeOfMeal = "";
  static List<FoodInfo> foods = <FoodInfo>[];
  static void removeFood(int index){
    foods.removeAt(index);
  }
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
  String generateMealName () {
    String todaysDate = DateFormat("MM-dd-yyyy").format(DateTime.now());
    return todaysDate + ' ' + RecordedData.typeOfMeal;
  }
  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    String foodNameList = generateMealName();
    List<String> names = RecordedData.generateFoodNames();
    prefs.setStringList(foodNameList, names);
  }
  Future<void> _saveMeal() async{
    await _saveName();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealResult()),
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

        floatingActionButton: Positioned(
          right: 10,
          bottom: 20,
          child: Column(
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                tooltip: 'Pick Image',
                  child: Icon(Icons.add_a_photo),
                ),
              FloatingActionButton(
                heroTag: null,
                onPressed: _saveMeal,
                child: Icon(Icons.add_a_photo),
              ),
            ],
          ),
        ),
    );

  }
}



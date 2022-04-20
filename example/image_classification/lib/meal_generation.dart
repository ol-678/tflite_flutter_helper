import 'package:flutter/material.dart';
import 'Food_info.dart';
import 'main.dart';

class RecordedData {
  static String typeOfMeal = "";
  static List<FoodInfo> foods = <FoodInfo>[];
}

class MealGeneration extends StatefulWidget {
  const MealGeneration({Key? key}) : super(key: key);

  @override
  State<MealGeneration> createState() => _MealGenerationState();
}

class _MealGenerationState extends State<MealGeneration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
      title: Text('Meal Generation'),),
      body: Center(
        child: Container (

        )
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    },
    tooltip: 'Pick Image',
    child: Icon(Icons.add_a_photo),
    ),
    );

  }
}



import 'package:flutter/material.dart';
import 'Food_info.dart';
import 'main.dart';

class RecordedData {
  static String typeOfMeal = "";
  static List<FoodInfo> foods = <FoodInfo>[];
  static void removeFood(int index){
    foods.removeAt(index);
  }
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
                    child: Text(RecordedData.foods[index].name)
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            )
        ),
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



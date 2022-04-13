import 'package:flutter/material.dart';
class MealSelection extends StatefulWidget {
  const MealSelection({Key? key}) : super(key: key);

  @override
  State<MealSelection> createState() => _MealSelectionState();
}

class _MealSelectionState extends State<MealSelection> {
  final List<String> entries = <String>['Breakfast', 'Lunch', 'Dinner'];
  final List<int> colorCodes = <int>[600, 500, 400];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Select your meal',
        style: TextStyle(color: Colors.white)),
    ),
    body:
        Center(
          child:
          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    height: 50,
                    color: Colors.amber[colorCodes[index]],
                    child: Center(child: Text('Entry ${entries[index]}')),
                  ),
                );
              }
          ),
        )

    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imageclassification/main.dart';
import 'Meal_selection.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E'];
  final List<int> colorCodes = <int>[600, 500, 200, 400, 300];
  String? _savedName;
  int lifetimeCal = 0;
  int lifetimeCarbs = 0;
  double lifetimeSugar = 0;
  int lifetimeSodium = 0;
  int lifetimeCholesterol = 0;

  final TextEditingController _nameController = TextEditingController();

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    int mealsEaten = prefs.getInt("meals")!;

    lifetimeCal = prefs.getInt("lifeTimeCalories")!;
    lifetimeCarbs = prefs.getInt("lifeTimeCarbs")!;
    lifetimeSugar = prefs.getDouble("lifeTimeSugar")!;
    lifetimeSodium = prefs.getInt("lifeTimeSodium")!;
    lifetimeCholesterol = prefs.getInt("lifeTimeCholesterol")!;

    double avgCalPerMeal = lifetimeCal / mealsEaten;
    double avgCarbsPerMeal = lifetimeCarbs / mealsEaten;
    double avgSugarPerMeal = lifetimeSugar / mealsEaten;
    double avgSodiumPerMeal = lifetimeSodium/ mealsEaten;
    double avgCholesterolPerMeal = lifetimeCholesterol / mealsEaten;
  }
  // Retrieve the saved name if it exists
  @override
  void initState() {
    super.initState();
    _retrieveName();
  }

  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.setString('name', _nameController.text);
    });
  }

  Future<void> _clearName() async {
    final prefs = await SharedPreferences.getInstance();
    // Check where the name is saved before or not
    if (!prefs.containsKey('name')) {
      return;
    }

    await prefs.remove('name');
    setState(() {
      _savedName = null;
    });
  }

  Future<void> _retrieveName() async {
    final prefs = await SharedPreferences.getInstance();

    // Check where the name is saved before or not
    if (!prefs.containsKey('name')) {
      return;
    }

    setState(() {
      _savedName = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    _retrieveName();
    if (_savedName == null)
      return Scaffold(
      appBar: AppBar(
        title: Text("Enter your name"),
      ),
      body: Center(
        child: Column(
          children:[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Your name"
              ),
            ),
            ElevatedButton(
              onPressed: _saveName,
              child: const Text(
                "save"
              ),
            )
          ]
        ),
      ),
    );
      else

      return Scaffold(
        body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(
                flex: 66,
                child: Column(
                  children: [
                    Text("Profile"),
                    Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.all(15),
                    child:
                    CircleAvatar(
                      backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3011/3011270.png")
                    ),
                    ),
                    Text(
                      "Welcome, "+ _savedName! + "!",
                          style: TextStyle(
                        fontSize: 20
                    ),
                    ),
                    Text(
                      "You have been doing great! Keep up the good diet!",
          ),
                    ElevatedButton(onPressed: _clearName, child: const Text("reset name"))
                      ],
                ),
              ),

              Expanded(
                flex: 90,
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Text("Recommendations"),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            color: Colors.amber[colorCodes[index]],
                            child: Center(child: Text('Entry ${entries[index]}')),
                          );
                        }
                    ),
                  ),
                  ],
                ),
              ),

            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MealSelection()),
          );
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:imageclassification/main.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
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
                      "Welcome, John Doe/Jane Doe!",
                          style: TextStyle(
                        fontSize: 20
                    ),
                    ),
                    Text(
                      "You have been doing great! Keep up the good diet!",
          ),
                      ],
                ),
              ),

              Expanded(
                flex: 66,
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
              Expanded(
                flex: 66,
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Text("Recent"),
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
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
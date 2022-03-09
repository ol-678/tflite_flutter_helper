import 'package:flutter/material.dart';
import 'dart:math';
<<<<<<< HEAD
import 'package:imageclassification/main.dart';

class splash_page extends StatefulWidget {
  @override
  _splash_pageState createState() => _splash_pageState();
}

class _splash_pageState extends State<splash_page> {

  void printLuckyNumber() {
    var rng = Random();
    print(rng.nextInt(100));
  }
=======

import 'package:imageclassification/main.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
>>>>>>> dfd41e4 (update)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
<<<<<<< HEAD
              Text("Profile"),
              Image.asset("assets/applogo.jpeg"),
              SizedBox(height:25),
              Text("Welcome to the Diabetes Food Nutrition App!"),
              Text("Copyright @ Olivia Lee, 2022")
=======

              Expanded(
                flex: 66,
                child: Column(
                  children: [
                    Text("Profile"),
                    Image.asset("assets/applogo.png"),
                  ],
                ),
              ),

              Expanded(
                flex: 66,
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Text("Welcome to Health App"),
                    Text("Copyright @ Olivia, 2022")
                  ],
                ),
              )

>>>>>>> dfd41e4 (update)
            ],
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:math';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Profile"),
              Image.asset("assets/applogo.jpeg"),
              SizedBox(height:25),
              Text("Welcome to the Diabetes Food Nutrition App!"),
              Text("Copyright @ Olivia Lee, 2022")
            ],
          ),
        )
    );
  }
}
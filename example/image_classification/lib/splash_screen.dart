import 'package:flutter/material.dart';
import 'dart:math';
import 'package:imageclassification/main.dart';
import 'dashboard_screen.dart';

class dashboard_screen extends StatefulWidget {
  @override
  _splash_pageState createState() => _splash_pageState();
}

class _splash_pageState extends State<splash_page> {

  void printLuckyNumber() {
    var rng = Random();
    print(rng.nextInt(100));
  }
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => dashboard_screen()),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[

              Expanded(
                flex: 30,
                child: Column(
                  children: [
                    Text("Profile"),
                    Image.asset("assets/applogo.jpeg"),
                  ],
                ),
              ),

                Expanded(
                  flex: 70,
                  child: Column(
                    children: [
                    SizedBox(height:25),
                    Text("Welcome to the Diabetes Food Nutrition App!"),
                    Text("Copyright @ Olivia Lee, 2022"),
                    ],
                  ),
                ),

            ],
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:imageclassification/main.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

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

            ],
          ),
        )
    );
  }
}
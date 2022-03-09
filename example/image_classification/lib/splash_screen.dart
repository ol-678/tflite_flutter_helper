import 'package:flutter/material.dart';
import 'package:imageclassification/dashboard_screen.dart';
import 'dart:math';

import 'package:imageclassification/main.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/applogo.png"),
              SizedBox(height: 25),
              Text("Welcome to Health App"),
              Text("Copyright @ Olivia, 2022")
            ],
          ),
        )
    );
  }
}
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageclassification/classifier.dart';
import 'package:imageclassification/classifier_quant.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'Food_info.dart';
import 'dashboard_screen.dart';
import 'food_dictionary.dart';
import 'meal_generation.dart';

void main() => runApp(MyApp());

//The setup code for the app.
//The first screen of this app is the dashboard page.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: DashboardPage(),
    );
  }
}

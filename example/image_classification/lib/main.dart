import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageclassification/classifier.dart';
import 'package:imageclassification/classifier_quant.dart';
import 'package:imageclassification/splash_screen.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'Food_info.dart';
import 'meal_generation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashPage(),
    );
  }
}

class _MealGenerationState extends State<MealGeneration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Meal Generation'),),
      body: Center(
          child: Container (

          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MealGeneration()),
          );
        },
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Classifier _classifier;

  FoodInfo? foodInfo;

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;

  img.Image? fox;

  Category? category;

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  Future getTakenPicture() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    setState(() {
      this.category = pred;
      foodInfo = getCorrespondingFood();
    });
  }
  FoodInfo getCorrespondingFood () {
    String classification = category!.label;
    switch (classification) {
      case "0 #1- Vegetables (lettuce)":
        return FoodInfo("lettuce", 5, 10, 0.3, 0, 1);
      case "1 #2- Meat (Chicken)":
        return FoodInfo("Chicken", 335, 115, 0, 123, 0);
      case "2 #3- Dairy (milk)":
        return FoodInfo("milk", 124, 116, 12, 20, 12);
      case "3 #4- Grains (bread) ":
        return FoodInfo("bread", 79, 147, 1.5, 0, 15);
      case "4 #5- Desserts (Ice cream)":
        return FoodInfo("Ice cream", 137, 53, 14, 29, 16);
      default:
        return FoodInfo("null", 0, 0, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TfLite Flutter Helper',
            style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: _image == null
                ? Text('No image selected')
                : Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 2),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: _imageWidget,
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Text(
            category != null ? foodInfo!.name: '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            category != null
                ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
                : '',
            style: TextStyle(fontSize: 16),
          ),

          Text(
            category != null
                ? 'Calories: ' + foodInfo!.calories.toString()
                : '',
            style: TextStyle(fontSize: 16),
          ),

          Text(
            category != null
                ? 'Sodium: ' + foodInfo!.sodium.toString() + ' miligrams'
                : '',
            style: TextStyle(fontSize: 16),
          ),

          Text(
            category != null
                ? 'Sugar: ' + foodInfo!.sugar.toString() + ' grams'
                : '',
            style: TextStyle(fontSize: 16),
          ),

          Text(
            category != null
                ? 'Cholesterol: ' + foodInfo!.cholesterol.toString() + ' miligrams'
                : '',
            style: TextStyle(fontSize: 16),
          ),

          Text(
            category != null
                ? 'Calories: ' + foodInfo!.carbohydrates.toString() + ' grams'
                : '',
            style: TextStyle(fontSize: 16),
          ),

          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: getImage,
            child: Icon(Icons.photo_library),),
            ElevatedButton(onPressed: getTakenPicture,
              child: Icon(Icons.add_a_photo),),
          ]

        )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (foodInfo != null) {
            RecordedData.foods.add(foodInfo!);
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MealGeneration()));
          }
          },
        child: Icon(Icons.check)
      )
    );
  }
}



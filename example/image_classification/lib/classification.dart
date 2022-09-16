import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageclassification/classifier.dart';
import 'package:imageclassification/classifier_quant.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'Food_info.dart';
import 'dashboard_screen.dart';
import 'food_dictionary.dart';
import 'meal_generation.dart';

class Classification extends StatefulWidget {
  Classification({Key? key}) : super(key: key);

  @override
  _ClassificationState createState() => _ClassificationState();
}

class _ClassificationState extends State<Classification> {

  //type of classifier algorithm we are using
  late Classifier _classifier;

  //represents information for whatever food client scans
  FoodInfo? foodInfo;

  //uploaded image from user
  File? _image;

  //used to grab image from user
  final picker = ImagePicker();

  //widget of uploaded image
  Image? _imageWidget;

  //prediction result
  Category? category;

  //set up the classifier
  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
  }

  Future getImage() async {
    //requests an image from the phone's image gallery
    final pickedFile = await picker.getImage(source: ImageSource.gallery).
    then((value) {
      if (value != null)
        {
          setState(() {
            _image = File(value!.path);
            _imageWidget = Image.file(_image!);

            //ask classifier to predict image
            _predict();
          });
        }
    });
  }

  Future getTakenPicture() async {
    //requests a photo from the phone's camera
    final pickedFile = await picker.getImage(source: ImageSource.camera).
    then((value) {
      if (value != null)
      {
        setState(() {
          _image = File(value!.path);
          _imageWidget = Image.file(_image!);

          //ask classifier to predict image
          _predict();
        });
      }
    });
  }

  void _predict() async {
    //format image for classifier to read
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    setState(() {
      this.category = pred;

      //based on the prediction, see what food the AI is talking about
      foodInfo = getCorrespondingFood();
    });
  }

  //the prediction results are just strings, we need to turn that into info
  FoodInfo getCorrespondingFood () {
    String classification = category!.label;

    //using a switch statement offers a clean and fast solution
    //Food_Dictionary is a class that contains a static dictionary
    //containing hard-coded references for all supported food types.
    switch (classification) {
      case "0 Apple":
        return Food_Dictionary.AllFoods["Apple"]!;
      case "1 Bread":
        return Food_Dictionary.AllFoods['Bread']!;
      case "2 Chocolate":
        return Food_Dictionary.AllFoods['Chocolate']!;
      case "3 Coffee":
        return Food_Dictionary.AllFoods['Coffee']!;
      case "4 Cooked Chicken":
        return Food_Dictionary.AllFoods['Cooked Chicken']!;
      case "5 Ice Cream":
        return Food_Dictionary.AllFoods['Ice Cream']!;
      case "6 Lettuce":
        return Food_Dictionary.AllFoods['Lettuce']!;
      case "7 Milk":
        return Food_Dictionary.AllFoods['Milk']!;
      case "8 Orange":
        return Food_Dictionary.AllFoods['Orange']!;
      case "9 Seafood":
        return Food_Dictionary.AllFoods['Seafood']!;
      default:
        //what happens when the AI's prediction doesn't match anything
        //if the AI was set up correctly, this should never show up during runtime
        return FoodInfo("null", 0, 0, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TfLite Flutter Helper',
              style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight:FontWeight.bold)),
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
                  ? 'Carbohydrates: ' + foodInfo!.carbohydrates.toString() + ' grams'
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


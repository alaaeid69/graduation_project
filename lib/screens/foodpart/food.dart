import 'package:flutter/material.dart';
import 'package:gradproj/screens/foodpart/dinner.dart';
import 'package:gradproj/screens/foodpart/lunch.dart';
import 'package:gradproj/screens/foodpart/snacks.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

import 'breakfast.dart';


class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});
  @override
  FoodScreenState createState() => FoodScreenState();
}

class FoodScreenState extends State<FoodScreen> {
  int _currentIndex = 0;
  final List<String> photoPaths = [
    'images/breakfast.jpg',
    'images/lunch.jpg',
    'images/diner.jpg',
    'images/snacks.jpg',
  ];

  final List<String> photoTexts = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const TextTitle(
            text: 'Food',
            textcolor: Colors.black,
          )
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 15),
          itemCount: photoPaths.length,
          itemBuilder: (context , index){
            _currentIndex = index;
            return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomRoundedImage(
                  imagesrc: photoPaths[_currentIndex],
                  action: (){
                    if(index == 0){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (v)=> BreakfastScreen())
                      );
                    }else if(index == 1){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (v)=> const LunchScreen())
                      );
                    }else if(index == 2){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (v)=> const DinnerScreen())
                      );
                    }else if(index == 3){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (v)=> const SnacksScreen())
                      );
                    }

                },
                  text: photoTexts[_currentIndex],
                ));
          }
      ),

    );
  }
}



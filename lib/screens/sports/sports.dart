import 'package:flutter/material.dart';
import 'package:gradproj/screens/sports/workout.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

import 'aerobics.dart';

class SportsScreen extends StatefulWidget {
  @override
  _SportsScreenState createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  int _currentIndex = 0;
  final List<String> photoPaths = [
    'images/workout.jpg',
    'images/aerobics.jpg',
  ];

  final List<String> photoTexts = [
    'Workouts',
    'Aerobics',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextTitle(
            text: 'Sports',
            textcolor: Colors.black,
          )),
    body: ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjusted padding here
      itemCount: photoTexts.length, // Display only two photos
      itemBuilder: (context, index) {
        _currentIndex = index;
        return Padding(
            padding: EdgeInsets.only(top: 20),
          child: CustomRoundedImage(
            imagesrc: photoPaths[_currentIndex],
            action: () {
              if (index == 0) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v) => Workout())
                );
              } else if (index == 1) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v) => Aerobics())
                );
              }
            },
            text: photoTexts[_currentIndex]
        ));
      }
    ),
    );

}
}
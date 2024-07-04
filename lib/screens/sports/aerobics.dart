import 'package:flutter/material.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

import 'Dancing.dart';
import 'Walking.dart';

class NavigationBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Pulse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Aerobics(),
    );
  }
}

class Aerobics extends StatefulWidget {
  @override
  _AerobicsScreenState createState() => _AerobicsScreenState();
}

class _AerobicsScreenState extends State<Aerobics> {
  int _currentIndex = 0;
  final List<String> photoPaths = [
    'images/walking.jpg',
    'images/dancing.jpg',
  ];

  final List<String> photoTexts = [
    'Walking',
    'Dancing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextTitle(
            text: 'Aerobics',
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
                            MaterialPageRoute(builder: (v) => Walking())
                        );
                      } else if (index == 1) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (v) => Dancing())
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

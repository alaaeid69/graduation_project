
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

import 'diabetes_types.dart';


class DiabetesInfo extends StatefulWidget {
  @override
  _DiabetesInfoState createState() => _DiabetesInfoState();
}

class _DiabetesInfoState extends State<DiabetesInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextTitle(
            text: 'What is Diabetes ?!',
            textcolor: Colors.black,
          )
        ),
        body: Column(
          children: [
            CustomRoundedImage(
                imagesrc: 'images/diabetes.png',
              action: () {  },
              text: '',
            ),
            _def(),
          ],
        )
    );
  }

  Widget _def() {
    return const Padding(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 40),
        child: Column(
          children: [
            NormalText(
                text: 'is a medical condition occurs when the body is unable'
                    ' to effectively use glucose as an energy source, either due to insufficient production'
                    ' of insulin or the body`s inability to respond properly to this hormone.',
              textcolor: Colors.black, weight: FontWeight.normal,
            ),
          ],
        )
    );
  }
}

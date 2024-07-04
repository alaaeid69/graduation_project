
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

import '../../theme/constants.dart';


class LowSugarComa extends StatefulWidget {
  @override
  _LowSugarComaComaState createState() => _LowSugarComaComaState();
}

class _LowSugarComaComaState extends State<LowSugarComa> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: TopImage(
      imagesrc: 'images/coma.png',
      widget: _diabetic_coma(),
      title: 'Low blood sugar\nComa',

    )));
  }
  Widget _diabetic_coma(){
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
    child: Column(
      children: [
        NormalText(
          text: '"Low blood sugar coma" is a state where blood sugar levels drop excessively low. If you feel these symptoms : eat a quick source of carbohydrates such as fruit juice. If you do not improve, you should call emergency.\n',
          textcolor: Colors.black, weight: FontWeight.normal,
        ),
        Row(
            children: [
              SubTitle(
                text: 'These are its symptoms:\n',
                textcolor: kButtonColor,
                weight: FontWeight.bold,
              )]),
        Row(
          children: [
            SubTitle(
              text: '1.Sweating          2.Trembling\n'
                  '\n3.Extreme            4.Headache\n   hunger\n'
                  '\n5.Blurred              6.Seizures\n   vision\n'
                  '\n7.Rapid                 8.Syncope\n   heartbeat           ',
              textcolor: Colors.black,
              weight: FontWeight.normal,
            ),
          ],),

      ],

    ));

  }
}


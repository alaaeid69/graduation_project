
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

import '../../theme/constants.dart';


class HyperglycemicComa extends StatefulWidget {
  @override
  _HyperglycemicComaState createState() => _HyperglycemicComaState();
}

class _HyperglycemicComaState extends State<HyperglycemicComa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: TopImage(
      imagesrc: 'images/coma.png',
      widget: _diabetic_coma(),
      title: 'Hyperglycemic Coma',

        )));
  }
  Widget _diabetic_coma(){
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
      child: Column(
          children: [
            NormalText(
                text: '"Hyperglycemic coma" refers to a state where blood sugar levels become excessively hight.\n',
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
                     text: '1.Extreme             2.Frequent\n   thirst                      urination\n'
                         '\n3.Fatigue &           4.Fruity\n   thredness              breath\n                                  odor\n'
                         '\n5.Nausea &           6.Rapid\n   vomiting                breathing\n'
                         '\n7.Blurred vision',
                     textcolor: Colors.black,
                   weight: FontWeight.normal,
                 ),
              ],),

          ],

    ));

  }
}


import 'package:flutter/material.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/text.dart';

import 'diabetes_def.dart';
import 'diabetes_types.dart';
import 'diabetic coma.dart';
import 'forbidden_food.dart';
import 'hyperglycemic_coma.dart';
import 'low_sugar_coma.dart';
import 'medical_examination.dart';


class SomeInformation extends StatefulWidget {
  @override
  _SomeInformationState createState() => _SomeInformationState();
}

class _SomeInformationState extends State<SomeInformation> {
  List<String> content = ['What is diabetes','Types of diabetes','Diabetic coma',
    '1.Hyperglycemic coma','2.Low blood sugar coma','Forbidden food','Medical examination'];
  int _current_index = 0;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: TextTitle(
        text: 'Some Information',
        textcolor: Colors.black,
      ),
    ),
    body: ListView.builder(
        itemCount: content.length,
        itemBuilder: (context,index){
          _current_index = index;
          return CustomCard(
              card_content: Padding(
                padding: EdgeInsets.only(left: 20,top: 20),
              child: SubTitle(
                text: content[_current_index],
                textcolor: Colors.black,
                weight: FontWeight.normal,
              )),
            card_height: 80,
            card_action: () {
              if(index == 0 ){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v)=> DiabetesInfo()));
              }else if(index == 1 ){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v)=> DiabetesTypes()));
              }else if(index == 2 ){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v)=> DiabeticComa()));
              }else if(index == 3 ){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v)=> HyperglycemicComa()));
              }
              else if(index == 4 ){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v)=> LowSugarComa()));
              }
              else if(index == 5 ){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v)=> ForbiddenFood()));
              }
              else if(index == 6 ){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v)=> MedicalExamination()));
              }
            },
          );
        }
    ),
  );

  }

}
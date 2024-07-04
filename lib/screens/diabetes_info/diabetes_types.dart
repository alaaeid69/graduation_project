
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';


class DiabetesTypes extends StatefulWidget {
  @override
  _DiabetesTypesState createState() => _DiabetesTypesState();
}

class _DiabetesTypesState extends State<DiabetesTypes> {
  List<String> types = ['1. Type 1: Body doesn`t produce insulin.',
    '2. Type 2: Insulin resistance or indequate production.',
    '3. Gestational: Develops during pregnancy, may resolve postpartum.'
  ];
  int current_index = 0;
  late int index;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: TextTitle(
            text: 'Diabetes types',
            textcolor: Colors.black,

          )
        ),
        body: Column(
          children: [
            CustomRoundedImage(
                imagesrc: 'images/diabetes_types.jpg',
              action: () {  },
              text: '',
            ),
            _types(),
          ],
        )
    );


  }
  Widget _types(){
    return Expanded(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index){
              current_index = index;
              return CustomCard(
                  card_content: text(),
                  card_height: 114,
                card_action: () {  },
              );
            }
        )

    );

  }
  Widget text(){
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
    child: SmallText(
        text: types[current_index],
        textcolor: Colors.black,
        weight: FontWeight.normal,
    ));

  }
}


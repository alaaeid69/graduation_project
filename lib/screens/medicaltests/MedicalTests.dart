import 'package:flutter/material.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

import 'A1C.dart';
import 'LFT.dart';
import 'Postprandial.dart';

class medicalTests extends StatefulWidget {
  @override
  State<medicalTests> createState() => _medicalTestsState();
  }

  class _medicalTestsState extends State<medicalTests> {
  List<String> test_name = ['A1C','Postprandial blood','LFT'];
  List<String> test_duration = ['from 3 to 6 months','2 hours after eating','from 1 to 2 years'];
  int  current_index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TopImage(
         title: 'Medical tests',
        imagesrc: 'images/blood-test.jpg',
        widget: Expanded(
        child: ListView.builder(
          itemCount: 3,
            itemBuilder: (context,index){
              current_index = index;
              return CustomCard(
                card_content: Padding(
                    padding: EdgeInsets.only(top: 20,left: 20),
                    child: Column(
                      children: [
                        Row(
                    children: [
                        SubTitle(
                            text: test_name[current_index],
                            textcolor: Colors.black,
                            weight: FontWeight.normal
                        )]),
                        Row(
                          children: [
                        SmallText(
                            text: test_duration[current_index],
                            textcolor: Colors.red,
                            weight: FontWeight.normal
                        )])
                      ],
                    )
                ),
                card_height: 100,
                card_action: () {
                  if(index == 0){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (v)=> A1c())
                    );
                  }else if(index == 1){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (v)=> Postprandial())
                    );
                  }else if(index == 2){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (v)=> LFT())
                    );
                  }
                },
              );
            }
        )),
    ));
    }

}

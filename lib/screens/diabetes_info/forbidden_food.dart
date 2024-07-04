import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

class ForbiddenFood extends StatefulWidget {
  @override
  _ForbiddenFoodState createState() => _ForbiddenFoodState();
}
class _ForbiddenFoodState extends State<ForbiddenFood> {
  int _current_index = 0;
  List<String> content = ['1.Avoid sugary foods and sweets.',
    '2.Limit consumption of fast food and high-fat foods.',
    '3.Choose whole grains over refined starches.',
    '4.Moderate alcohol intake or avoid it.',
    '5.Opt for fresh fruits over sweetened juices.',
    '6.Limit soda and artificially sweetened drinks.'];

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: TopImage(
         imagesrc: 'images/becareful.png',
         widget: Expanded(
         child: ListView.builder(
           itemCount: content.length,
             itemBuilder: (context,index){
               _current_index = index;
               return CustomCard(
                 card_content: Padding(
                   padding: EdgeInsets.only(left: 15,top: 20),
                 child: NormalText(
                   text: content[_current_index],
                   textcolor: Colors.black, weight: FontWeight.normal,
                 )),
                 card_height: 114,
                 card_action: () {  },
               );
             }
         )),
         title: 'Be careful!'
     ));

  }

}
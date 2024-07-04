import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

class MedicalExamination extends StatefulWidget {
  @override
  _MedicalExaminationState createState() => _MedicalExaminationState();
}
class _MedicalExaminationState extends State<MedicalExamination> {
  int _current_index = 0;
  List<String> content = ['1.Checking fat levels.',
    '2.Examination of the feet to prevent diabetic foot infection.',
    '3.Dental examination to prevent gum disease.',
    '4.Fundus examination.',
    '5.Heart examination.'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TopImage(
            imagesrc: 'images/medical_examination.png',
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
            title: 'Medical examination'
        ));

  }

}
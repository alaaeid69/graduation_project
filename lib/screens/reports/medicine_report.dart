import 'package:flutter/material.dart';
import 'package:gradproj/widgets/cards.dart';

import '../../theme/constants.dart';
import '../../widgets/calender.dart';
import '../../widgets/text.dart';

class MedicineReport extends StatefulWidget {
  @override
  _MedicineReportState createState() => _MedicineReportState();
}

class _MedicineReportState extends State<MedicineReport> {
  int _currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  List<String> medicine_name = ['metformin','omega3'];
  List<String> dosage = ['2','1'];
  List<bool> dosage_taken = [true , false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(
            text: 'Medicine',
            textcolor: Colors.black
        ),
      ),
      body: _reportPageWidget(),
    );

  }
  Widget _reportPageWidget(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 30),
          child: Row(
              children: [
                const SubTitle(
                  text: 'select date',
                  textcolor: Colors.black,
                  weight: FontWeight.bold,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child:  Calender(onDateChanged: (value) {
                      
                    },)
                ),
              ]),
        ),
               CustomCard(
                      card_action: (){},
                        card_height: 570,
                        card_content: Padding(
                           padding: const EdgeInsets.only( right:   30),
                        child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(left: 30, top: 20),
                                child: Row(
                                    children: [
                                      SmallText(
                                        text: 'Medicine',
                                        textcolor: Colors.black,
                                        weight: FontWeight.bold,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 100),
                                          child: SmallText(
                                            text: 'Dosage',
                                            textcolor: Colors.black,
                                            weight: FontWeight.bold,
                                          )),
                                    ]
                                )),
                            SizedBox(
                              height: 450,
                            child: ListView.builder(
                                itemCount: medicine_name.length,
                                itemBuilder: (context , index){
                                  _currentIndex = index;
                           return Padding(
                               padding: const EdgeInsets.only(left: 30,top: 20),
                             child: Row(
                              children: [
                                    SmallText(
                                      text: medicine_name[_currentIndex],
                                      textcolor: kButtonColor,
                                      weight: FontWeight.bold,
                                    ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 100),
                               child: SmallText(
                                      text: dosage[_currentIndex],
                                      textcolor: kButtonColor,
                                      weight: FontWeight.bold,
                                    )),
                               const Spacer(flex: 1,),
                                  Icon(
                                    dosage_taken[_currentIndex]? Icons.check_circle : Icons.highlight_remove,
                                    color: dosage_taken[_currentIndex]? Colors.green : Colors.red,

                                )
                              ],
                            ));
                                }),

                             )

                          ],
                        )))



      ],
    );
  }
}

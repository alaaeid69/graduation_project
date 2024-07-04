import 'package:flutter/material.dart';
import 'package:gradproj/widgets/button.dart';

import '../../theme/constants.dart';
import '../../widgets/cards.dart';
import '../../widgets/text.dart';

class MedicalTestsReport extends StatefulWidget {
  @override
  _MedicalTestsReportState createState() => _MedicalTestsReportState();
}

class _MedicalTestsReportState extends State<MedicalTestsReport> {
  int _currentIndex = 0;
  List<String> test_name = ['A1C','A1C','Postprandial blood','LFT','LFT'];
  List<String> test_kind = ['A1C','eAg','Blood sugar','ALT','AST'];
  List<String> eAg_perc = ['7.0','5.0'];
  List<String> a1c_perc = ['6','20'];
  List<String> sugar_perc = ['200','140','150'];
  List<String> alt_perc = ['24'];
  List<String> ast_perc = ['42'];
  List<String> a1c_time =  ['5 pm','8 am'];
  List<String> postprandal_time =  ['10 pm','5 pm','12 am'];
  List<String> lft_time = ['6 pm'];
  List<String> a1c_date =  ['5-5-2024','10-5-2024'];
  List<String> postprandal_date =  ['8-30-2020','6-12-2024','9-6-2024'];
  List<String> lft_date = ['7-9-2024'];
  late List<String> test_perc ;
  late List<String> test_time ;
  late List<String> test_date ;
  late String second_text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextTitle(
          text: 'Medical Tests',
          textcolor: Colors.black,
        ),

      ),
      body: _reportPageWidget(),
    );

  }
  Widget _reportPageWidget(){
    return Padding(padding: EdgeInsets.only(top: 30),
      child: Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context,index){
                if(index == 0){
                  test_perc = a1c_perc ;
                  test_time = a1c_time;
                  test_date = a1c_date;
                  second_text = ' %';
                }else if(index == 1){
                  test_perc = eAg_perc ;
                  test_time = a1c_time;
                  test_date = a1c_date;
                  second_text = ' mmol';
                }else if(index == 2){
                  test_perc = sugar_perc ;
                  test_time = postprandal_time;
                  test_date = postprandal_date;
                  second_text = ' mg/dl';
                }else if(index == 3){
                  test_perc = alt_perc ;
                  test_time = lft_time;
                  test_date = lft_date;
                  second_text = ' UI/I';
                }else if(index == 3){
                  test_perc = ast_perc ;
                  test_time = lft_time;
                  test_date = lft_date;
                  second_text = ' UI/I';
                }
                _currentIndex = index;
                return CustomCard(
                        card_height: 300,
                        card_action: (){},
                        card_content: Column(
                          children: [
                        Padding(
                        padding: EdgeInsets.only(left: 30, top: 20),
                            child: Row(
                                children: [
                                  SmallText(
                                  text: test_name[_currentIndex]+' :',
                                  textcolor: Colors.black,
                                    weight: FontWeight.bold,
                            )])),
                             Padding(
                                padding: EdgeInsets.only(left: 30, top: 15),
                                child: Row(
                                    children: [
                                      SmallText(
                                        text: test_kind[_currentIndex],
                                        textcolor: Colors.black,
                                        weight: FontWeight.bold,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 40),
                                          child: SmallText(
                                            text: 'Time',
                                            textcolor: Colors.black,
                                            weight: FontWeight.bold,
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: SmallText(
                                            text: 'Date',
                                            textcolor: Colors.black,
                                            weight: FontWeight.bold,
                                          )),
                                    ]
                                )),
                            SizedBox(
                              height: 200,
                            child: ListView.builder(
                             itemCount: test_perc.length,
                             itemBuilder: (context , index){
                               _currentIndex = index;
                             return Padding(
                                   padding: EdgeInsets.only(left: 30, top :10),
                               child: Row(
                              children: [
                                      SmallText(
                                      text: test_perc[_currentIndex] + second_text,
                                      textcolor: kButtonColor,
                                      weight: FontWeight.bold,
                                    ),
                                Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: SmallText(
                                      text: test_time[_currentIndex],
                                      textcolor: Colors.red,
                                      weight: FontWeight.bold,
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: SmallText(
                                      text: test_date[_currentIndex],
                                      textcolor: Colors.red,
                                      weight: FontWeight.bold,
                                    )),
                              ],
                               ));}
                )),

                          ],
                        )

                );
              }
          ),
        ),
      Padding(padding: EdgeInsets.only(top: 20,bottom: 30),
      child: CalculateButton(
          title: 'Download',
          onTap: (){

          },
          buttonbackcolor: kButtonColor,
          buttontextcolor: Colors.white
      )
      ),

      ],
    ));
  }
}
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/calender.dart';
import 'package:gradproj/widgets/cards.dart';

import '../../theme/constants.dart';
import '../../widgets/text.dart';

class FoodReport extends StatefulWidget {
  @override
  _FoodReportState createState() => _FoodReportState();
}

class _FoodReportState extends State<FoodReport> {
  int _currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  List<String> meal_name = ['Breakfast','Lunch','Dinner','Snacks'];
  List<String> breakfast_kind = ['egg','bread'];
  List<String> lunch_kind = ['fish','rice'];
  List<String> dinner_kind = ['pizza'];
  List<String> snacks_kind = ['nuts'];
  List<String> breakfast_kcal = ['100','200'];
  List<String> lunch_kcal = ['150','200'];
  List<String> dinner_kcal = ['300'];
  List<String> snacks_kcal = ['100'];
  late List<String> food_kind ;
  late List<String> food_kcal ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextTitle(
            text: 'Food',
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
          padding: EdgeInsets.fromLTRB(20, 30, 0, 20),
          child: Row(
              children: [
                SubTitle(
                  text: 'select date',
                  textcolor: Colors.black,
                  weight: FontWeight.bold,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 0),
                    child:  Calender(onDateChanged: (value) {
                      
                    },)
                ),
              ]),
        ),
        Column(
          children: [
            SubTitle(
                text: 'Total',
                textcolor: Colors.black,
                weight: FontWeight.bold
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: SmallText(
                text: '304.6'+' KCal',
                textcolor: Colors.red,
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context,index){
                _currentIndex = index;
                if(index == 0){
                  food_kind = breakfast_kind ;
                  food_kcal = breakfast_kcal;
                }else if(index == 1){
                  food_kind = lunch_kind ;
                  food_kcal = lunch_kcal;
                }else if(index == 2){
                  food_kind = dinner_kind ;
                  food_kcal = dinner_kcal;
                }else if(index == 3){
                  food_kind = snacks_kind ;
                  food_kcal = snacks_kcal;
                }
                return CustomCard(
                  card_height: 300,
                  card_action: (){},
                  card_content: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 20, 45, 0),
                            child: Row(
                                children: [
                                  SmallText(
                                    text: meal_name[_currentIndex],
                                    textcolor: Colors.black,
                                    weight: FontWeight.bold,
                                  ),
                                  Spacer(flex: 1,),
                                  SmallText(
                                    text: 'KCal',
                                    textcolor: Colors.black,
                                    weight: FontWeight.bold,

                                  ),
                                ]
                            )),
                        SizedBox(
                            height: 250,
                            child: ListView.builder(
                                itemCount: food_kind.length,
                                itemBuilder: (context,index) {
                                  _currentIndex = index;
                                  return Padding(
                                      padding: EdgeInsets.fromLTRB(30, 10, 40, 0),
                                      child: Row(
                                        children: [
                                          SmallText(
                                            text: food_kind[_currentIndex],
                                            textcolor: kButtonColor,
                                            weight: FontWeight.bold,
                                          ),
                                          Spacer(flex: 1,),
                                          SmallText(
                                            text: food_kcal[_currentIndex],
                                            textcolor: Colors.red,
                                            weight: FontWeight.bold,
                                          ),
                                        ],
                                      ));
                                } )),
                      ]),
                );
              }
          ),
        ),

      ],
    );
  }
}
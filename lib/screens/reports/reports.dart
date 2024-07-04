
import 'package:flutter/material.dart';
import 'package:gradproj/screens/reports/sports_report.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/text.dart';
import 'food_report.dart';
import 'medicaltest_report.dart';
import 'medicine_report.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  int _currentIndex=0;
  List<String> items=['Sports','Food','Medicine','Medical Tests'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
       // automaticallyImplyLeading: false,
        title: TextTitle(
        text: 'Reports',
        textcolor: Colors.black,
    ),

    ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
            _currentIndex = index;
            return CustomCard(
              card_content: Padding(
                padding: EdgeInsets.only(left: 20,top: 20),
                child: SubTitle(
                text: items[_currentIndex],
                textcolor: Colors.black,
                weight: FontWeight.normal,

              )),
              card_height: 80,
              card_action: (){
                if(index == 0 ){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (v)=> SportsReport()));
                }else if(index == 1 ){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (v)=> FoodReport()));
                }else if(index == 2 ){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (v)=> MedicineReport()));
                }else if(index == 3 ){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (v)=> MedicalTestsReport()));
                }
              },

            );
          }
      ),



    );
  }
}

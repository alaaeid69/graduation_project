import 'package:flutter/material.dart';
import 'package:gradproj/widgets/calender.dart';
import 'package:gradproj/widgets/cards.dart';

import '../../theme/constants.dart';
import '../../widgets/text.dart';

class SportsReport extends StatefulWidget {
  @override
  _SportsReportState createState() => _SportsReportState();
}

class _SportsReportState extends State<SportsReport> {
  int _currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  List<String> sport_name = ['Walking', 'Dancing', 'Workouts'];
  List<String> walking_kind = ['1 Mile', '3 Mile', '6 Mile'];
  List<String> dancing_kind = ['Zomba', 'Dance'];
  List<String> workouts_kind = ['Dynamic Chest'];

  List<String> walking_kcal = ['100', '200', '300'];
  List<String> dancing_kcal = ['100-150', '150 - 200'];
  List<String> workouts_kcal = ['4.6'];
  late List<String> sport_kind;
  late List<String> sport_kcal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextTitle(text: 'Sports', textcolor: Colors.black),
      ),
      body: _reportPageWidget(),
    );
  }

  Widget _reportPageWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 0, 20),
          child: Row(children: [
            SubTitle(
              text: 'select date',
              textcolor: Colors.black,
              weight: FontWeight.bold,
            ),
            Padding(
                padding: EdgeInsets.only(left: 0),
                child: Calender(
                  onDateChanged: (value) {},
                )),
          ]),
        ),
        Column(
          children: [
            SubTitle(
                text: 'Total',
                textcolor: Colors.black,
                weight: FontWeight.bold),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: SmallText(
                text: '304.6' + ' KCal',
                textcolor: Colors.red,
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                _currentIndex = index;
                if (index == 0) {
                  sport_kind = walking_kind;
                  sport_kcal = walking_kcal;
                } else if (index == 1) {
                  sport_kind = dancing_kind;
                  sport_kcal = dancing_kcal;
                } else if (index == 2) {
                  sport_kind = workouts_kind;
                  sport_kcal = workouts_kcal;
                }
                return CustomCard(
                  card_height: 300,
                  card_action: () {},
                  card_content: Column(children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(30, 20, 45, 0),
                        child: Row(children: [
                          SmallText(
                            text: sport_name[_currentIndex],
                            textcolor: Colors.black,
                            weight: FontWeight.bold,
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          SmallText(
                            text: 'KCal',
                            textcolor: Colors.black,
                            weight: FontWeight.bold,
                          ),
                        ])),
                    SizedBox(
                        height: 250,
                        child: ListView.builder(
                            itemCount: sport_kind.length,
                            itemBuilder: (context, index) {
                              _currentIndex = index;
                              return Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 40, 0),
                                  child: Row(
                                    children: [
                                      SmallText(
                                        text: sport_kind[_currentIndex],
                                        textcolor: kButtonColor,
                                        weight: FontWeight.bold,
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      SmallText(
                                        text: sport_kcal[_currentIndex],
                                        textcolor: Colors.red,
                                        weight: FontWeight.bold,
                                      ),
                                    ],
                                  ));
                            })),
                  ]),
                );
              }),
        ),
      ],
    );
  }
}

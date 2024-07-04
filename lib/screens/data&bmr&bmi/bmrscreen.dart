// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../theme/constants.dart';
import '../../widgets/button.dart';
import '../../widgets/cards.dart';
import '../../widgets/text.dart';
import 'bmi_calculator.dart';
import 'datascreen.dart';

class BMRScreen extends StatelessWidget {
  const BMRScreen(
      {super.key,
      required this.bmrResult,
      required this.currentCalorie,
      required this.icon,
      required this.bmiResult});

  final String currentCalorie, bmrResult;
  final IconData icon;
  final String bmiResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: TextTitle(
              text: "BMR Calculator",
              textcolor: Colors.black,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               CustomCard(
                 card_height: 550,
                  card_action: (){},
                  card_content: Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                      TextTitle(
                        text: "Daily calorie needs ",
                        textcolor: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                      TextTitle(
                        text: currentCalorie.toString(),
                        textcolor: kButtonColor,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                       NormalText(
                        text: "Calories / Day",
                        textcolor: Colors.black,
                         weight: FontWeight.normal,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                      Icon(
                        icon,
                        size: 100,
                        color: kButtonColor,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 80, 0, 0)),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: CalculateButton(
                                  title: "Continue",
                                  buttonbackcolor: kButtonColor,
                                  buttontextcolor: Colors.white,
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (v) => BMICalculator(
                                                bmiResult:
                                                    bmiResult.toString())));
                                  }),
                            ),
                            // Spacer(
                            //   flex: 1,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
        );
  }
}

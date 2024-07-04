
import 'package:flutter/material.dart';
import '../../theme/constants.dart';
import '../../widgets/button.dart';
import '../../widgets/cards.dart';
import '../../widgets/text.dart';
import '../main_screens/mainscreen.dart';

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key, required this.bmiResult});
  final String bmiResult;

  @override
  Widget build(BuildContext context) {
    late String weight_status;
    late Color text_color;
    if (double.parse(bmiResult) < 18.5) {
      weight_status = 'Thin';
      text_color = Colors.amber;
    } else if (double.parse(bmiResult) >= 18.5 &&
        double.parse(bmiResult) <= 25) {
      weight_status = 'Normal';
      text_color = kButtonColor;
    } else if (double.parse(bmiResult) > 25 && double.parse(bmiResult) <= 35) {
      weight_status = 'Overweight';
      text_color = Colors.orange;
    } else if (double.parse(bmiResult) > 35) {
      weight_status = 'Obese overweight';
      text_color = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(
          text: "BMI Calculator",
          textcolor: Colors.black,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomCard(
            card_action: () {},
            card_height: 550,
            card_content: Column(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                const TextTitle(
                  text: "BMI Result",
                  textcolor: Colors.black,
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                TextTitle(
                  text: bmiResult.toString(),
                  textcolor: kButtonColor,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextTitle(
                      text: weight_status,
                      textcolor: text_color,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: CalculateButton(
                      title: "Continue",
                      buttonbackcolor: kButtonColor,
                      buttontextcolor: Colors.white,
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (v) => MainPage()));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import '../../theme/constants.dart';
// import '../../widgets/button.dart';
// import '../../widgets/cards.dart';
// import '../../widgets/text.dart';
// import '../main_screens/mainscreen.dart';


// class BMICalculator extends StatelessWidget {
//   const BMICalculator({super.key, required this.bmiResult});
//   final String bmiResult;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           appBar: AppBar(
//             title: TextTitle(
//               text: "BMI Calculator",
//               textcolor: Colors.black,
//             ),
//           ),
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//                CustomCard(
//                  card_action: (){},
//                  card_height: 550,
//                   card_content: Column(
//                     children: [
//                       Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
//                       TextTitle(
//                         text: "BMI Result",
//                         textcolor: Colors.black,
//                       ),
//                       Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
//                       TextTitle(
//                         text: bmiResult.toString(),
//                         textcolor: kButtonColor,
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.only(top: 150),
//                         child:  CalculateButton(
//                               title: "Continue",
//                               buttonbackcolor: kButtonColor,
//                               buttontextcolor: Colors.white,
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (v) => MainPage()));
//                               }),
//                         ),

//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         );
//   }
// }

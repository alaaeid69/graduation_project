
import 'package:flutter/material.dart';
import 'package:gradproj/screens/data&bmr&bmi/bmrscreen.dart';
import 'package:gradproj/screens/data&bmr&bmi/datascreen.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/cards.dart';

import '../../theme/constants.dart';
import '../../widgets/text.dart';
import 'bmr_calculator.dart';

var exerciseList = [
  "Little to no exercise",
  "Light exercise\n(1–3 days per week)",
  "Moderate exercise\n(3–5 days per week)",
  "Heavy exercise\n(6–7 days per week)",
  "Exercise\n(twice per day)"
];

class UserActivityData extends StatefulWidget {
  const UserActivityData({super.key, this.age, this.weight, this.height, required this.gender});

  final age, weight, height;
  final Gender gender;

  @override
  _UserActivityDataState createState() => _UserActivityDataState();
}

class _UserActivityDataState extends State<UserActivityData> {
  String _activity = exerciseList[0];

  late int age, weight, height;
   Gender? gender;
  int _current_index = 0;
  @override
  void initState() {
    height = widget.height;
    weight = widget.weight;
    age = widget.age;
    gender = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const TextTitle(
          text: "Activity level",
         textcolor: Colors.black
        ),
      ),
      body: SizedBox(
        child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: exerciseList.length,
                          itemBuilder: (context , index){
                            _current_index = index;
                            return CustomCard(
                                card_content: RadioListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                child: NormalText(
                                      text: exerciseList[_current_index],
                                      textcolor: Colors.black,
                                    weight: FontWeight.normal,
                                  )),
                                  activeColor: kButtonColor,
                                  value: exerciseList[_current_index],
                                  groupValue: _activity,
                                  onChanged: ((value) {
                                    setState(() {
                                      _activity = value!;
                                    });
                                  }),
                                ),
                                card_height: 100,
                                card_action: (){}
                            );
                          }
                     )),
                         Padding(
                           padding: const EdgeInsets.only(top: 20,bottom: 20),
                         child: CalculateButton(
                            title: "Continue",
                            buttonbackcolor: kButtonColor,
                            buttontextcolor: Colors.white,
                            onTap: () {
                              CalculatorBrain calculatorBrain = CalculatorBrain(
                                age: age,
                                weight: weight,
                                height: height,
                                gender: gender ?? Gender.female,
                                activity: _activity,
                              );

                              print(_activity);
                              showDialog(context: context, builder:
                              (BuildContext context){
                                return AlertDialog(
                                  content: const SubTitle(
                                    text: 'Do you want to save changes ?',
                                    textcolor: Colors.black,
                                    weight: FontWeight.normal,
                                  ),
                                  actions: [
                                    Row(
                                    children: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BMRScreen(
                                                bmrResult: calculatorBrain.result(),
                                                icon: calculatorBrain.getGenderIcon(),
                                                bmiResult: calculatorBrain.getBMIResult(),
                                                currentCalorie:
                                                calculatorBrain.getActivity(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: const SmallText(
                                          textcolor: kButtonColor,
                                          text: 'Cancel',
                                          weight: FontWeight.bold,
                                        )
                                    ),
                                      TextButton(
                                          onPressed: (){
                                            //save data back work
                                            Navigator.of(context).push(
                                              MaterialPageRoute(builder: (v) => BMRScreen(
                                                bmrResult: calculatorBrain.result(),
                                                icon: calculatorBrain.getGenderIcon(),
                                                bmiResult: calculatorBrain.getBMIResult(),
                                                currentCalorie:
                                                calculatorBrain.getActivity(),
                                              ),
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 100),
                                           child: SmallText(
                                            textcolor: kButtonColor,
                                            text: 'Ok',
                                            weight: FontWeight.bold,
                                          ))
                                      ),
                                ])
                                  ],
                                );
                              }
                              );
                            })),

                  ],
                ),
              ),
            );
  }
}

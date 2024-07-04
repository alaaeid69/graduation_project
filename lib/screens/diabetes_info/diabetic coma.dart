import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/custom_textfield.dart';
import 'package:gradproj/widgets/divider.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/constants.dart';

class DiabeticComa extends StatefulWidget {
  @override
  _DiabeticComaState createState() => _DiabeticComaState();
}

class _DiabeticComaState extends State<DiabeticComa> {
  TextEditingController firstNumber = TextEditingController();
  TextEditingController secondNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: TopImage(
      imagesrc: 'images/coma.png',
      widget: _diabetic_coma(),
      title: 'Dibetic coma',
    )));
  }

  Widget _diabetic_coma() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: Column(
          children: [
            const NormalText(
              text: 'There are two types of coma:\n'
                  '1. low-glycemic coma\n'
                  '2. hight-glycemic coma\n'
                  '\nif you feel any of their sympotoms, click on',
              textcolor: Colors.black,
              weight: FontWeight.normal,
            ),
            const Row(
              children: [
                NormalText(
                  text: 'Emergency',
                  textcolor: kButtonColor,
                  weight: FontWeight.normal,
                ),
                NormalText(
                  text: ' at the home page',
                  textcolor: Colors.black,
                  weight: FontWeight.normal,
                ),
              ],
            ),
            const PageDivider(
                padding_left: 0,
                padding_top: 15,
                padding_right: 0,
                padding_bottom: 10),
            const NormalText(
              text:
                  'Enter 2 numbers and we will send a message to them to help you quickly in emergency state.',
              textcolor: Colors.black,
              weight: FontWeight.normal,
            ),
            Row(
              children: [
                const NormalText(
                  text: 'Number 1',
                  textcolor: kButtonColor,
                  weight: FontWeight.normal,
                ),
                CustomTextField(
                  hintText: '',
                  controller: firstNumber,
                  isPassword: false,
                  padding_left: 15,
                  padding_top: 0,
                  padding_right: 0,
                  padding_bottom: 0,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  children: [
                    const NormalText(
                      text: 'Number 2',
                      textcolor: kButtonColor,
                      weight: FontWeight.normal,
                    ),
                    CustomTextField(
                      hintText: '',
                      controller: secondNumber,
                      isPassword: false,
                      padding_left: 15,
                      padding_top: 0,
                      padding_right: 0,
                      padding_bottom: 0,
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            CalculateButton(
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                prefs.setString('firstNumber', firstNumber.text);
                prefs.setString('secondNumber', secondNumber.text);
                log('=============' + prefs!.getString('firstNumber')!);
                log('=============' + prefs!.getString('secondNumber')!);

                Navigator.of(context).pop();
              },
              title: 'Save',
              buttonbackcolor: kButtonColor,
              buttontextcolor: Colors.white,
            )
          ],
        ));
  }
}

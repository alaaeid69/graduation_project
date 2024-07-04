import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/screens/welcome&login/thirdwelcome.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/button.dart';

import '../../theme/constants.dart';

class SecondWelcome extends StatefulWidget{
  @override
  State<SecondWelcome> createState() => _SecondWelcomeState();
}

class _SecondWelcomeState extends  State<SecondWelcome> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(children: [
          Stack(
            children: [
              BackgroundImage(
                  imagesrc:
                  "images/secondwelimg.png"
              )
              ,
              Padding(
                padding: EdgeInsets.fromLTRB(110, 715, 0, 0),
                child: CalculateButton(
                  title: 'Get started',
                  onTap:  (){
                    Navigator
                        .of(context).push(
                        MaterialPageRoute(builder: (v)=> ThirdWelcome())
                    );
                  },
                  buttonbackcolor: kButtonColor,
                  buttontextcolor: Colors.white
              ))
            ],
          )
        ]),
    );
  }
}
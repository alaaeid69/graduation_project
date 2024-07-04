import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/button.dart';

import '../../theme/constants.dart';
import 'login.dart';

class ThirdWelcome extends StatefulWidget{
  @override
  State<ThirdWelcome> createState() => _ThirdWelcomeState();
}

class _ThirdWelcomeState extends  State<ThirdWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(children: [
          Stack(
            children: [
              BackgroundImage(
                  imagesrc: "images/thirdwelimg.png"
              ),
          Padding(
            padding: EdgeInsets.fromLTRB(150, 715, 0, 0),
            child: CalculateButton(
                   title: 'Next',
                   onTap: (){
                     Navigator.of(context).push(
                         MaterialPageRoute(builder: (v)=> Login())
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
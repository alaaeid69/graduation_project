import 'package:flutter/material.dart';
import 'package:gradproj/screens/welcome&login/secondwel.dart';
import 'package:gradproj/widgets/image.dart';

class Welcome extends StatefulWidget{
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            BackgroundImage(
                imagesrc: "images/welcomeback5.png"
            ),
        Padding(
            padding: EdgeInsets.fromLTRB(290, 740, 0, 0),
            child: TextButton(
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (v)=> SecondWelcome())
            );
          },
          child: Image(
            image: AssetImage('images/arrow3.png'),
          ),
        )),
          ],
        )
    );

  }
}
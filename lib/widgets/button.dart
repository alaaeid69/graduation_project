import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.buttonbackcolor,
    required this.buttontextcolor,
    // required this.padding_top,
    // required this.padding_bottom,
    // required this.padding_left,
    // required this.padding_right,
  });

  final String title;
  final VoidCallback onTap;
  final Color buttonbackcolor;
  final  Color buttontextcolor;
  // final double padding_top;
  // final double padding_bottom;
  // final double padding_left;
  // final double padding_right;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 50,
           // width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: buttonbackcolor,//kButtonColor,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
              title,
              //textAlign: TextAlign.center,
              style:  TextStyle(
                fontSize: 20,
                color: buttontextcolor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            )),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/text.dart';


class RectangleIconButton extends StatelessWidget {
  const RectangleIconButton({super.key,
    required this.onPressed,
    required this.backcolor,
    required this.icon_name,
    required this.icon_padding_top,
    required this.icon_padding_left,
    required this.text_padding_left,
    required this.text
  });
  final VoidCallback onPressed;
  final Color backcolor;
  final IconData icon_name;
  final double icon_padding_top;
  final double icon_padding_left;
  final double text_padding_left;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: backcolor,
            borderRadius: BorderRadius.circular(100)
          ),
          child: Column(
          children: [
        Padding(
          padding: EdgeInsets.only(top: icon_padding_top,left: icon_padding_left),
        child: Icon(
            icon_name ,
            color: Colors.white,
          size: 60,
        )),
            Padding(
                padding: EdgeInsets.fromLTRB(text_padding_left,0,30,20),
            child: SubTitle(
                text: text,
                textcolor: Colors.white,
                weight: FontWeight.bold
            ))
    ]),
      // style: ElevatedButton.styleFrom(
      //   shape: CircleBorder(),
      //   backgroundColor: backcolor
      // ),
    ));
  }
}

class CustomIconButton extends StatelessWidget{
  const CustomIconButton({
   super.key,
    required this.icon_name,
    required this.action,

});
  final IconData icon_name;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Icon(
        icon_name,
        size: 25,
        weight: 900,
      ),
      onPressed: action,
      color: kButtonColor,
      textColor: Colors.white,
      shape: CircleBorder(),
    );
  }

}

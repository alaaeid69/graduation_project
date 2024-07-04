import 'package:flutter/material.dart';
import 'package:gradproj/widgets/text.dart';

class LeftIconWithText extends StatelessWidget{
  const LeftIconWithText({
    super.key,
    required this.icon_name,
    required this.text,
    required this.weight,

   });
  final IconData  icon_name;
  final String text;
  final FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Icon(
            icon_name ,
            color: Colors.black,
            size: 35,
          ),
          Padding(
              padding: EdgeInsets.only(left: 8 ),
              child: SubTitle(
              text: text,
              textcolor: Colors.black,
              weight: weight
          ))
        ]
    );
  }

}
class SmallIcon extends StatelessWidget{
  const SmallIcon({
    super.key,
    required this.icon_name,
    required this.action,

  });
  final IconData  icon_name;
  final VoidCallback action ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
        child: Icon(
            icon_name ,
            color: Colors.red,
            size: 25,
    ));
  }

}
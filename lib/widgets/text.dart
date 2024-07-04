import 'package:flutter/material.dart';


class BigText extends StatelessWidget{
  const BigText({
    super.key,
    required this.text,
    required this.textcolor,


  });
  final String text;
  final Color textcolor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textcolor,
          fontSize: 35,
          fontWeight: FontWeight.bold
      ),
    );
  }

}

class TextTitle extends StatelessWidget{
  const TextTitle({
    super.key,
    required this.text,
    required this.textcolor,

});
  final String text;
  final Color textcolor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textcolor,
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
    );
  }

}
class SubTitle extends StatelessWidget{
  const SubTitle({
    super.key,
    required this.text,
    required this.textcolor,
    required this.weight,

  });
  final String text;
  final Color textcolor;
  final FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textcolor,
          fontSize: 20,
          fontWeight: weight
      ),
    );
  }
}
class NormalText extends StatelessWidget{
  const NormalText({
    super.key,
    required this.text,
    required this.textcolor,
    required this.weight,

  });
  final String text;
  final Color textcolor;
  final FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: weight,
          color: textcolor,
          fontSize: 18,
         // fontWeight: FontWeight.bold
      ),
    );
  }

}
class SmallText extends StatelessWidget{
  const SmallText({
    super.key,
    required this.text,
    required this.textcolor,
    required this.weight,

  });
  final String text;
  final Color textcolor;
  final FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textcolor,
          fontSize: 16,
          fontWeight: weight
      ),
    );
  }

}

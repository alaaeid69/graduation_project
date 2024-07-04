import 'package:flutter/material.dart';
import '../theme/constants.dart';

class CircularCard extends StatelessWidget {
  const CircularCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor,
          boxShadow: kBoxShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: child,
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget{
  const CustomCard({
  super.key,
  required this.card_content,
  required this.card_height,
  required this.card_action
  });

   final Widget card_content ;
   final double card_height;
   final VoidCallback card_action;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
        child: GestureDetector(
          onTap: card_action,
        child: Container(
          height: card_height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFFFBFDFF),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],

          ),
          child: card_content,
        )));
  }

}

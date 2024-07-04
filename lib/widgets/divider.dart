import 'package:flutter/material.dart';



class PageDivider extends StatelessWidget{
  const PageDivider({
    super.key,
    required this.padding_left,
    required this.padding_top,
    required this.padding_right,
    required this.padding_bottom,
});
  final double padding_left;
  final double padding_top;
  final double padding_right;
  final double padding_bottom;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(padding_left,padding_top,padding_right,padding_bottom),
      child: Divider(
      thickness: 2.7,
      indent: 45,
      endIndent: 90,
      color: Color.fromRGBO(8, 97, 231, 1.0),
    ));
  }

}
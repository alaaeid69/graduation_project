import 'package:flutter/material.dart';
import 'package:gradproj/theme/constants.dart';



class CustomTextField extends StatelessWidget{
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isPassword,
    this.onChanged,
    required this.padding_left,
    required this.padding_top,
    required this.padding_right,
    required this.padding_bottom,
    this.validator,
});

  final String Function(String?)? validator;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final Function(String)? onChanged;
  final double padding_left;
  final double padding_top;
  final double padding_right;
  final double padding_bottom;
  @override
  Widget build(BuildContext context) {
   return Expanded(
     child: Padding(
       padding: EdgeInsets.fromLTRB(padding_left, padding_top, padding_right, padding_bottom),
     child: TextFormField(
       validator: (data) {
         if(data!.isEmpty){
           return  'this field is required';
         } return null;
       } ,
     onChanged: onChanged,
     style: const TextStyle(
         color: Color.fromRGBO(8, 97, 231, 1.0),
         height: 1,
     ),
     controller: controller,
     decoration: InputDecoration(
       hintText: hintText,
       filled: true,
       fillColor: const Color.fromRGBO(236, 234, 234, 1.0),
       border: OutlineInputBorder(
         borderSide: BorderSide.none,
         borderRadius: BorderRadius.circular(15),
       ),
     ),
     obscureText: isPassword,
   )
    ));
  }

}
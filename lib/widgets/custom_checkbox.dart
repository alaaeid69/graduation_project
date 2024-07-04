import 'package:flutter/material.dart';
import 'package:gradproj/widgets/text.dart';

import '../theme/constants.dart';



class CustomCheckbox extends StatefulWidget{
  const CustomCheckbox({
    super.key,
    required this.checkbox_title,
    required this.checkboxtitle_widget,
  });
  final String checkbox_title;
  final Widget checkboxtitle_widget;
  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
  }

  class _CustomCheckboxState extends State<CustomCheckbox> {
   bool isChecked = false;
   bool isNotFound = false;
  @override
  Widget build(BuildContext context) {
    if(widget.checkbox_title == 'Not Found'){
      setState(() {
        isNotFound = true;
      });
    }
    return CheckboxListTile(
        activeColor: kButtonColor,
        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        controlAffinity: ListTileControlAffinity.leading,
        title: widget.checkboxtitle_widget,
        enabled: isNotFound? false : true,
        value: isChecked,
        onChanged: (val){
          setState(() {
            isChecked = val!;
          });

        }
    );
  }

}
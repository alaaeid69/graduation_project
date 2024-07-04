import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

 customAwesomeDialog ({required BuildContext buildContext,
required String title,
required DialogType dialogType,
required String description,
 VoidCallback? cancelOnPressed,
 VoidCallback? okOnPressed,
 AnimType? animType,
 }) {

    return AwesomeDialog(
      context: buildContext,
      btnOkText: 'Ok',
      showCloseIcon: true,
      autoHide: const Duration(seconds: 3),
      animType: animType ?? AnimType.rightSlide,
      dialogType: dialogType,
      title: title,
      btnOkOnPress: okOnPressed,
      desc: description,
      dialogBackgroundColor: Colors.white,
      btnCancelOnPress: cancelOnPressed,
      borderSide: const BorderSide(color: Colors.black),
      alignment: Alignment.center,
      titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      descTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ).show();

}

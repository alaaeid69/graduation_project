
import 'package:flutter/material.dart';

import 'constants.dart';


// ignore: non_constant_identifier_names
ThemeData CustomTheme() => ThemeData.light(useMaterial3: true).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryColor,
      ),
      scaffoldBackgroundColor: kBackgroundColor,
      sliderTheme: const SliderThemeData().copyWith(
        overlayColor: kButtonColor,
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            kButtonColor,
          ),
        ),
      ),
    );

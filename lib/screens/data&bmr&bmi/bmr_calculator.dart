import 'package:flutter/material.dart';
import 'package:gradproj/screens/data&bmr&bmi/datascreen.dart';

import '../../theme/constants.dart';

class CalculatorBrain {
  final int age, weight, height;
  final Gender gender;
  final String activity;

  late double _bmr;

  late double heightInMeter = height / 100;
  late double _calorie_activity, bmi;

  CalculatorBrain({
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.activity,
  });
  //BMI calculator
  String getBMIResult() {
    bmi = (weight / (heightInMeter * heightInMeter));
    return bmi.toStringAsFixed(2);
  }

  double _calculateBMRMale() {
    return (10 * weight.toDouble()) +
        (6.25 * height.toDouble()) -
        (5 * age) +
        5;
  }

  double _calculateBMRFemale() {
    return (10 * weight.toDouble()) +
        (6.25 * height.toDouble()) -
        (5 * age) -
        161;
  }

  String _getMaleBMR() {
    _bmr = _calculateBMRMale();
    return _bmr.toStringAsFixed(2);
  }

  String _getFemaleBMR() {
    _bmr = _calculateBMRFemale();
    return _bmr.toStringAsFixed(2);
  }

  bool _isMale() {
    return gender == Gender.male;
  }

  bool _isFemale() {
    return gender == Gender.female;
  }

  void _checkGenderToCalculate() {
    if (_isMale()) {
      _calculateBMRMale();
    } else if (_isFemale()) {
      _calculateBMRFemale();
    }
  }

  IconData getGenderIcon() {
    if (_isMale()) {
      return Icons.male;
    } else {
      return Icons.female;
    }
  }

  String result() {
    _checkGenderToCalculate();
    if (_isMale()) {
      return _getMaleBMR();
    } else if (_isFemale()) {
      return _getFemaleBMR();
    } else {
      return '';
    }
  }

  String getActivity() {
    if (activity == "Little to no exercise") {
      _calorie_activity = _bmr * 1.2;
    } else if (activity == "Light exercise\n(1–3 days per week)") {
      _calorie_activity = _bmr * 1.375;
    } else if (activity == "Moderate exercise\n(3–5 days per week)") {
      _calorie_activity = _bmr * 1.55;
    } else if (activity == "Heavy exercise\n(6–7 days per week)") {
      _calorie_activity = _bmr * 1.725;
    } else {
      _calorie_activity = _bmr * 1.9;
    }
    return _calorie_activity.toStringAsFixed(2);
  }
}

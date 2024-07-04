import 'package:flutter/material.dart';
import 'package:gradproj/widgets/text.dart';

import '../theme/constants.dart';
import 'cards.dart';

class CustomTimePicker extends StatefulWidget {
  final String cancle_text;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const CustomTimePicker(
      {Key? myKey, required this.cancle_text, required this.onTimeChanged})
      : super(key: myKey);

  @override
  CustomTimePickerState createState() => CustomTimePickerState();
}

class CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 12, minute: 00);

  void _showTimePicker() {
    showTimePicker(
      cancelText: widget.cancle_text,
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: kButtonColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: kButtonColor,
            onBackground: Colors.white,
            onSecondary: Colors.white,
            secondary: kButtonColor,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child as Widget,
      ),
    ).then((value) {
      setState(() {
        _timeOfDay = value ?? TimeOfDay.now();
        widget.onTimeChanged(_timeOfDay);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          card_action: () {},
          card_height: 50,
          card_content: OutlinedButton(
            onPressed: _showTimePicker,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(width: 1.0, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(0.0),
              child: SubTitle(
                text: _timeOfDay.format(context).toString(),
                textcolor: Colors.black,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

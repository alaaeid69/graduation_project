import 'package:flutter/material.dart';
import 'package:gradproj/widgets/text.dart';
import '../theme/constants.dart';
import 'cards.dart';

class Calender extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;

  Calender({required this.onDateChanged});

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      card_action: () async {
        final DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
          builder: (context, child) => Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.light(
                primary: kButtonColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: kButtonColor,
                onBackground: Colors.white,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child as Widget,
          ),
        );
        if (dateTime != null) {
          setState(() {
            selectedDate = dateTime;
            widget.onDateChanged(selectedDate);
          });
        }
      },
      card_height: 50,
      card_content: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: SubTitle(
          text:
              '${selectedDate.month} - ${selectedDate.day} - ${selectedDate.year}',
          textcolor: Colors.black,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gradproj/widgets/text.dart';

import '../theme/constants.dart';
import 'cards.dart';

class CustomDropDownlist extends StatefulWidget {
  String selected;
  final List<String> items;
  final String month_or_year;
  final ValueChanged<String?> onChanged;

  CustomDropDownlist(
      {Key? myKey,
      required this.selected,
      required this.items,
      required this.month_or_year,
      required this.onChanged})
      : super(key: myKey);

  @override
  _CustomDropDownlistState createState() => _CustomDropDownlistState();
}

class _CustomDropDownlistState extends State<CustomDropDownlist> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCard(
          card_content: DropdownButton<String>(
            borderRadius: BorderRadius.circular(20),
            value: widget.selected,
            underline: SizedBox(),
            menuMaxHeight: 200,
            icon: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: Colors.black,
                size: 35,
              ),
            ),
            items: widget.items
                .map((item) => DropdownMenuItem(
                    value: item,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: SubTitle(
                        text: item + ' ' + widget.month_or_year,
                        textcolor: Colors.black,
                        weight: FontWeight.bold,
                      ),
                    )))
                .toList(),
            onChanged: (item) {
              setState(() {
                widget.selected = item!;
                widget.onChanged(item);
              });
            },
          ),
          card_height: 50,
          card_action: () {},
        ),
      ],
    );
  }
}

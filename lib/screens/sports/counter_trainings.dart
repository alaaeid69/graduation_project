import 'package:flutter/material.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/text.dart';
import '../../widgets/vedio.dart';
class CounterTrainings extends StatefulWidget {
  final String link;
  final String trainingName;
  const CounterTrainings(
      {Key? key, required this.link, required this.trainingName})
      : super(key: key);
  @override
  State<CounterTrainings> createState() => _CounterTrainingsState();
}

class _CounterTrainingsState extends State<CounterTrainings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextTitle(
            text: widget.trainingName,
            textcolor: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.fromLTRB(20, 150, 20, 100),
                height: 600,
                width: 700,
                child: VideoPlayerWidget(
                  link: widget.link,
                )),
            CalculateButton(
              title: 'Done',
              onTap: () {
                //backend action (save training name in database & display it and it's date in sports_report page
                Navigator.pop(context);
              },
              buttonbackcolor: kButtonColor,
              buttontextcolor: Colors.white,
            ),
          ]),
        ));
  }
}

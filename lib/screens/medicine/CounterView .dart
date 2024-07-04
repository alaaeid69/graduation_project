import 'package:flutter/material.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/text.dart';

class CounterScreen extends StatefulWidget {
  final ValueChanged<double> onDosageChanged;

  CounterScreen({required this.onDosageChanged});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  double _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 0.5;
      widget.onDosageChanged(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter -= 0.5;
        widget.onDosageChanged(_counter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            SizedBox(
              width: 30.0,
              height: 30.0,
              child: FloatingActionButton.small(
                onPressed: _decrementCounter,
                backgroundColor: kButtonColor,
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            AnimatedOpacity(
              opacity: _counter != 0 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 100),
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextTitle(
                  text: '$_counter',
                  textcolor: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 30.0,
              height: 30.0,
              child: FloatingActionButton.small(
                onPressed: _incrementCounter,
                backgroundColor: kButtonColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFBFDFF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: 155,
      height: 60,
    );
  }
}

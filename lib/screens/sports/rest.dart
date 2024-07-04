import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gradproj/theme/constants.dart';
import '../../widgets/text.dart';

const countdownDuration = Duration(seconds: 30);
Duration duration = const Duration();
Timer? timer;
bool isCountdown = true;
bool isButtonActive = true;
final addSeconds = isCountdown ? -1 :1;
//var seconds = duration.inSeconds + addSeconds;

class Rest extends StatefulWidget{
  @override
  State<Rest> createState() => _RestState();
}
class _RestState extends State<Rest> {
  /* static const countdownDuration = Duration(seconds: 30);
  Duration duration = Duration();
  Timer? timer;
  bool isCountdown = true;
  bool isButtonActive = true;
*/
  @override
  void initState(){
    super.initState();
    startTimer();
    reset();
  }
  void reset(){
    if(isCountdown){
      setState(() {
        duration = countdownDuration;
      });}else{
      setState(() {
        duration = const Duration();
      });
    }
  }

  void addTime(){

    // final addSeconds = isCountdown ? -1 :1;
    setState(() {
      var seconds = duration.inSeconds + addSeconds;
      if(seconds < 0){
        timer?.cancel();
        // isButtonActive = true;
        /*  Navigator.of(context).push(
            MaterialPageRoute(builder: (v)=> Rest2()));*/
      }else {
        duration = Duration(seconds: seconds);
      }});

  }
  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1),(_) => addTime());
  }
  void stopTimer({bool resets = true}){
    if(resets){
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor:  kButtonColor ,
          body: Container(

            child: _page(),
          ),
        );
  }
  Widget _timer(){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text('$minutes:$seconds',
      style: const TextStyle(fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }
  Widget _page(){
    return  Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,0),
      child: Center(
        child: Column(
          children: [
            ClipRRect(
                borderRadius:  const BorderRadius.only(bottomLeft: Radius.circular(35),bottomRight: Radius.circular(35)),
                child: Image.asset('images/rest1png.png')),
            const Padding(padding: EdgeInsets.only(top: 100)),
           const BigText(
               text: 'Rest',
               textcolor: Colors.white
           ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            _timer(),
            const Padding(padding: EdgeInsets.only(top: 50)),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              child: const SizedBox(
                  width: 120,
                  height: 50,
                  child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SubTitle(
                  text: 'Skip',
                  textcolor: kButtonColor,
                   weight: FontWeight.bold
                  )),
    ),

            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton(
              onPressed: isButtonActive ?
                  (){
                //backend work : add 20 seconds to timer duration
                setState(() {
                  isButtonActive = false;

                });

              } : null,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, disabledForegroundColor: const Color.fromRGBO(255, 255, 255, 1.0).withOpacity(0.38), disabledBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0).withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              child: const SizedBox(
                width: 120,
                height: 50,
                child: Padding(
               padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: SubTitle(
                    text: '+20s',
                    textcolor: kButtonColor,
                    weight: FontWeight.bold
                ))
              ),
            ),
          ],
        ),),
    );
  }


}
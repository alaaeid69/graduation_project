
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gradproj/screens/sports/rest.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/calender.dart';
import '../../widgets/text.dart';
import '../../widgets/vedio.dart';


const countdownDuration = Duration(seconds: 30);
Duration duration = const Duration();
Timer? timer;
bool isCountdown = true;
bool isButtonActive = true;
final addSeconds = isCountdown ? -1 :1;

class TimerTrainings extends StatefulWidget{
  final String link;
  const TimerTrainings({Key? key, required this.link, }) : super(key: key);
  @override
  State<TimerTrainings> createState() => _TimerTrainingsState();
}

class _TimerTrainingsState extends State<TimerTrainings> {
  @override
  void initState() {
    super.initState();
    startTimer();
    reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() {
        duration = countdownDuration;
      });
    } else {
      setState(() {
        duration = const Duration();
      });
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
        Navigator.of(context).push(
              MaterialPageRoute(builder: (v) => Rest()
          ));
        // change page content to the next training
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }

 @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const TextTitle(
          text: 'Dynamic chest',
          textcolor:Colors.black
        ),
      ),
        body: Container(

          child: _page(),
        ),


    );
  }

  Widget _page(){
    return   Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: const CustomSmallRoundedImage(imagesrc: 'images/dynamic_chest_left.jpg',)
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: const CustomSmallRoundedImage(imagesrc: 'images/dynamic_chest_right.jpg',)
                    ),

                  ],
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB( 20, 30, 20,0 ),
                    height: 300,
                    width: 700,
                    child: VideoPlayerWidget(link: widget.link,)),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: _timer(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70 , top: 30),
                  child: Row(
                    children: [
                      Padding(padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          child: Image.asset('images/left_triangle.png'),
                          onTap:  (){
                            Navigator.pop(context);
                          },
                        ),),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(fixedSize: const Size.fromWidth(165),
                            backgroundColor: kButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),

                        onPressed: (){
                          if(timer!.isActive){
                            stopTimer(resets:false);
                          }else{
                            startTimer();
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              timer!.isActive?   Icons.pause : Icons.play_arrow_rounded ,
                              color: Colors.white,
                              size: 30,
                            ),
                            SubTitle(
                              text: timer!.isActive? 'Pause' : 'Resume',
                              textcolor: Colors.white,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      GestureDetector(
                        child: Image.asset('images/right_triangle.png'),
                        onTap:  (){
                        // change page content to the next training
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
  }
  Widget _timer(){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return BigText(
       text: '$minutes:$seconds',
       textcolor: Colors.black,

    );
  }
}
  class CustomSmallRoundedImage extends StatelessWidget {
    const CustomSmallRoundedImage({
      super.key,
        required this.imagesrc,
    });

    final String imagesrc;

    @override
    Widget build(BuildContext context) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        child: Image.asset(
          imagesrc,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          width: 150,
          height: 150,
        ),
      );
    }
  }

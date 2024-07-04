import 'package:flutter/material.dart';
import 'package:gradproj/widgets/image.dart';
import 'List_View1.dart';

class Workout extends StatefulWidget {
  const Workout({super.key});
  @override
  WorkoutScreenState createState() => WorkoutScreenState();
}

class WorkoutScreenState extends State<Workout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: TopImage(
      imagesrc: 'images/workout.jpg',
      title: 'Workouts',
      widget: Expanded(child: List1()),
    ));
  }
}

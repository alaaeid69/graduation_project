import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/screens/sports/counter_trainings.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

class Walking extends StatefulWidget {
  const Walking({super.key});

  @override
  WalkingState createState() => WalkingState();
}

class WalkingState extends State<Walking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TopImage(
            imagesrc: 'images/walking.jpg',
            widget: Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('walking')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var workout = snapshot.data?.docs[index];
                      var mile = workout?['mile'];
                      var kcal = workout?['kcal'];
                      var link = workout?['link'];

                      return WalkingListViewItem(
                        mile: mile,
                        kcal: kcal,
                        link: link,
                      );
                    },
                  );
                },
              ),
            ),
            title: 'Walking'));
  }
}

class WalkingListViewItem extends StatelessWidget {
  final String mile;
  final String kcal;
  final String link;

  const WalkingListViewItem({
    super.key,
    required this.mile,
    required this.kcal,
    required this.link,

    // required this.image2Url,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      card_content: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(children: [
            NormalText(
              text: mile,
              textcolor: Colors.black,
              weight: FontWeight.bold,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 150),
              child: NormalText(
                text: kcal,
                textcolor: Colors.red,
                weight: FontWeight.bold,
              ),
            )
          ])),
      card_height: 80,
      card_action: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (v) => CounterTrainings(
                  link: link,
                  trainingName: mile,
                )));
        if (kDebugMode) {
          print(link);
        }
      },
    );
  }
}

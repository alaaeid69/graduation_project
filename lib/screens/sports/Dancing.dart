import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/screens/sports/counter_trainings.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';

import '../../widgets/vedio.dart';

class Dancing extends StatefulWidget {
  @override
  _DancingState createState() => _DancingState();
}

class _DancingState extends State<Dancing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TopImage(
            imagesrc: 'images/dancing.jpg',
            widget: Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('dancing')
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
                      var mile = workout?['name'];
                      var kcal = workout?['kcal'];
                      var link = workout?['link'];

                      return DancingListViewItem(
                        name: mile,
                        kcal: kcal,
                        link: link,
                      );
                    },
                  );
                },
              ),
            ),
            title: 'Dancing'));
  }
}

class DancingListViewItem extends StatelessWidget {
  final String name;
  final String kcal;
  final String link;

  const DancingListViewItem({
    super.key,
    required this.name,
    required this.kcal,
    required this.link,

    // required this.image2Url,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      card_content: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Row(children: [
                NormalText(
                  text: name,
                  textcolor: Colors.black,
                  weight: FontWeight.bold,
                ),
                Spacer(
                  flex: 1,
                ),
                NormalText(
                  text: kcal,
                  textcolor: Colors.red,
                  weight: FontWeight.bold,
                ),
              ]))),
      card_height: 80,
      card_action: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (v) => CounterTrainings(
                  link: link,
                  trainingName: name,
                )));
        print(link);
      },
    );
  }
}

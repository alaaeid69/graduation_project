import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Container.dart';

class List1 extends StatelessWidget {
  const List1({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('workout').snapshots(),
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
              var name = workout?['name'];
              var time = workout?['time'];
              var kcal = workout?['Kcal'];
              var video = workout?['video'];
              var images = workout?['image'] as List<dynamic>;

              // Accessing image_1 and image_2 from the array of maps
              var image1Url = images[0]['image_1'];
              // var image2Url = images[1]['image_2'];

              return Container1(
                name: name,
                time: time,
                kcal: kcal,
                image1Url: image1Url,
                videoUrl: video,
                //  image2Url: image2Url,
              );
            },
          );
        },
      ),
    );
  }
}

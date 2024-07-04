import 'package:flutter/material.dart';
import 'package:gradproj/screens/sports/counter_trainings.dart';
import 'package:gradproj/widgets/text.dart';
import '../../widgets/cards.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage

class Container1 extends StatelessWidget {
  final String name;
  final String time;
  final String kcal;
  final String image1Url;
  final String videoUrl;
  //final String image2Url;

  const Container1({
    super.key,
    required this.name,
    required this.time,
    required this.kcal,
    required this.image1Url,
    required this.videoUrl,
    // required this.image2Url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: CustomCard(
            card_height: 80,
            card_action: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (v) => CounterTrainings(
                      link: videoUrl,
                      trainingName: name,
                    ))),
            card_content: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
                child: Row(children: [
                  CachedNetworkImage(
                    imageUrl: image1Url,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 50,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Column(children: [
                        Row(children: [
                          SmallText(
                            text: name,
                            textcolor: Colors.black,
                            weight: FontWeight.bold,
                          )
                        ]),
                        Row(
                          children: [
                            SmallText(
                              text: time,
                              textcolor: Colors.red,
                              weight: FontWeight.normal,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: SmallText(
                                text: kcal,
                                textcolor: Colors.red,
                                weight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                      ]))
                ]))));
  }
}

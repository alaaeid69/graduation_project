import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/text.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.imagesrc,
  });

  final String imagesrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Image.asset(
        imagesrc,
        fit: BoxFit.cover,
      ),
    );
  }
}

class CustomRoundedImage extends StatelessWidget {
  const CustomRoundedImage(
      {super.key,
      required this.imagesrc,
      required this.action,
      required this.text});

  final String imagesrc;
  final VoidCallback action;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
          onTap: action,
          child: Container(
              width:
                  MediaQuery.of(context).size.width - 32, // Adjusted width here
              height: MediaQuery.of(context).size.height / 4.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagesrc,
                  fit: BoxFit.cover,
                ),
              ))),
      Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: TextTitle(
            text: text,
            textcolor: Colors.white,
          )),
    ]);
  }
}

class TopImage extends StatelessWidget {
  const TopImage({
    super.key,
    required this.imagesrc,
    required this.widget,
    required this.title,
  });

  final String imagesrc;
  final Widget widget;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        SizedBox(
          width: 400,
          height: 230,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.asset(
              imagesrc,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ))),
                TextTitle(text: title, textcolor: Colors.white),
              ],
            ))
      ]),
      widget,
    ]);
  }
}

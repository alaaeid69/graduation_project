import 'package:flutter/material.dart';
import 'package:gradproj/screens/diabetes_info/some_information.dart';
import 'package:gradproj/screens/foodpart/food.dart';
import 'package:gradproj/screens/medicaltests/MedicalTests.dart';
import 'package:gradproj/screens/medicine/medicine1.dart';
import 'package:gradproj/screens/sports/sports.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/calender.dart';
import 'package:gradproj/widgets/image.dart';
import 'package:gradproj/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  HomePageScreenState createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePageScreen> {
  int _currentIndex = 0;
  final List<String> photoPaths = [
    'images/diabetes_types.jpg',
    'images/mfitness1.jpg',
    'images/food2.jpg',
    'images/medicine.jpg',
    'images/blood-test.jpg',
  ];

  final List<String> photoTexts = [
    'Some Information',
    'Sport',
    'Food',
    'Medicine',
    'Medical Tests',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const TextTitle(
                    text: 'Health pulse',
                    textcolor: Colors.black,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: GestureDetector(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          makePhoneCall(
                              prefs.getString('firstNumber') ?? '123');
                          // sendSMS('0123456789');
                        },
                        child: const Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: InkWell(
                              child: SmallText(
                                text: 'Emergency',
                                textcolor: Colors.red,
                                weight: FontWeight.bold,
                              ),
                            )),
                      )),
                ],
              ))),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SmallText(
                    text: 'Currently Date: ',
                    textcolor: kButtonColor, // Set the color to blue
                    weight: FontWeight.bold,
                  ),
                  Calender(
                    onDateChanged: (value) {},
                  ),
                ],
              )),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 15),
                  itemCount: photoPaths.length,
                  itemBuilder: (context, index) {
                    _currentIndex = index;
                    return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomRoundedImage(
                          imagesrc: photoPaths[_currentIndex],
                          action: () {
                            if (index == 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (v) => SomeInformation()));
                            } else if (index == 1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (v) => SportsScreen()));
                            } else if (index == 2) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (v) => const FoodScreen()));
                            } else if (index == 3) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (v) => const Medicine()));
                            } else if (index == 4) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (v) => medicalTests()));
                            }
                          },
                          text: photoTexts[_currentIndex],
                        ));
                  })),
        ],
      ),
    );
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      throw 'Could not launch $launchUri';
    }
  }

  static Future<void> sendSMS(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      throw 'Could not launch $launchUri';
    }
  }
}

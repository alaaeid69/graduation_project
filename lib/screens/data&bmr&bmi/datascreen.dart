import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproj/widgets/text.dart';
import '../../theme/constants.dart';
import '../../widgets/button.dart';
import '../../widgets/cards.dart';
import '../../widgets/rectangle_icon_button.dart';
import 'user_activity_data.dart';

enum Gender {
  male,
  female,
}

class DataHomeScreen extends StatefulWidget {
  const DataHomeScreen({Key? key}) : super(key: key);

  @override
  State<DataHomeScreen> createState() => _DataHomeScreenState();
}

class _DataHomeScreenState extends State<DataHomeScreen> {
  Gender selectedGender = Gender.male;
  int age = 19;
  int height = 170;
  int weight = 65;

  // Update user data in Firestore
  void updateUserInFirestore() {
    final CollectionReference users = FirebaseFirestore.instance.collection('users');
    final String userId = FirebaseAuth.instance.currentUser!.uid; // Implement this function to get the user's ID

    String genderString = '';
    if (selectedGender == Gender.male) {
      genderString = 'male';
    } else if (selectedGender == Gender.female) {
      genderString = 'female';
    }
    final userData = {
      'gender': genderString,
      'age': age,
      'height': height,
      'weight': weight,
    };
    users.doc(userId).update(userData)
        .then((value) => print("User data updated successfully"))
        .catchError((error) => print("Failed to update user data: $error"));

    FirebaseFirestore.instance.collection('selected_items').doc(userId).set(
        {
          'gender': genderString,
          'age': age,
          'height': height,
          'weight': weight,
          'items' : [],
        }
    );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tell us about yourself",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                RectangleIconButton(
                  onPressed: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  backcolor: selectedGender == Gender.male ? kButtonColor : const Color.fromRGBO(145, 143, 143, 1.0),
                  icon_name: Icons.male,
                  icon_padding_top: 30,
                  icon_padding_left: 0,
                  text_padding_left: 20,
                  text: 'Male',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: RectangleIconButton(
                    onPressed: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    backcolor: selectedGender == Gender.female ? kButtonColor : const Color.fromRGBO(145, 143, 143, 1.0),
                    icon_name: Icons.female,
                    icon_padding_top: 20,
                    icon_padding_left: 0,
                    text_padding_left: 20,
                    text: 'Female',
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CircularCard(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Height (cm)",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        height.toString(),
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Slider(
                      value: height.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          height = value.toInt();
                        });
                      },
                      activeColor: const Color(0xFF0861E7),
                      thumbColor: const Color(0xFF0861E7),
                      overlayColor: MaterialStateProperty.all(const Color.fromARGB(255, 165, 196, 241)),
                      min: 120,
                      max: 220,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: CircularCard(
                    child: Column(
                      children: [
                        const SubTitle(
                          text: "Age",
                          textcolor: Colors.black,
                          weight: FontWeight.bold,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SubTitle(
                              text: age.toString(),
                              textcolor: Colors.black,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: CustomIconButton(
                                    icon_name: Icons.remove,
                                    action: () {
                                      setState(() {
                                        age--;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: CustomIconButton(
                                  icon_name: Icons.add,
                                  action: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CircularCard(
                    child: Column(
                      children: [
                        const SubTitle(
                          text: "Weight (kg)",
                          textcolor: Colors.black,
                          weight: FontWeight.bold,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SubTitle(
                              text: weight.toString(),
                              textcolor: Colors.black,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomIconButton(
                                  action: () {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                  icon_name: Icons.remove,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomIconButton(
                                  action: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                  icon_name: Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: CalculateButton(
              title: "Continue",
              buttonbackcolor: kButtonColor,
              buttontextcolor: Colors.white,
              onTap: () {
                updateUserInFirestore();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserActivityData(
                      height: height,
                      weight: weight,
                      gender: selectedGender,
                      age: age,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

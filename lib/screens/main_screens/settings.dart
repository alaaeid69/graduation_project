import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/icons.dart';
import 'package:gradproj/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../welcome&login/login.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(
          text: 'Settings',
          textcolor: Colors.black,
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var userData = snapshot.data?.data() as Map<String, dynamic>;
            bool isMale = userData['gender'] == 'male';
            print(isMale);
            num height = userData['height'];
            num weight = userData['weight'];
            num age = userData['age'];
            var heightInMeter = height / 100;
            var bmi = (weight / (heightInMeter * heightInMeter));
            var bmrMale =
                (10 * weight.toDouble()) + (6.25 * height.toDouble()) - (5 * age) + 5;
            var bmrFemale =
                (10 * weight.toDouble()) + (6.25 * height.toDouble()) - (5 * age) - 161;
            return Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Column(
                children: [
                  LeftIconWithText(
                    icon_name: Icons.person,
                    text: userData['username'].toString(),
                    weight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      children: [
                        const Column(
                          children: [
                            NormalText(
                              text: 'Gender\n',
                              textcolor: kButtonColor,
                              weight: FontWeight.normal,
                            ),
                            NormalText(
                              text: 'Height\n',
                              textcolor: kButtonColor,
                              weight: FontWeight.normal,
                            ),
                            NormalText(
                              text: 'Weight\n',
                              textcolor: kButtonColor,
                              weight: FontWeight.normal,
                            ),
                            NormalText(
                              text: 'Age\n',
                              textcolor: kButtonColor,
                              weight: FontWeight.normal,
                            ),
                            NormalText(
                              text: 'BMR\n',
                              textcolor: kButtonColor,
                              weight: FontWeight.normal,
                            ),
                            NormalText(
                              text: 'BMI',
                              textcolor: kButtonColor,
                              weight: FontWeight.normal,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 130),
                          child: Column(
                            children: [
                              NormalText(
                                text: userData['gender'] + '\n',
                                textcolor: kButtonColor,
                                weight: FontWeight.normal,
                              ),
                              NormalText(
                                text: '$height\n',
                                textcolor: kButtonColor,
                                weight: FontWeight.normal,
                              ),
                              NormalText(
                                text: '$weight\n',
                                textcolor: kButtonColor,
                                weight: FontWeight.normal,
                              ),
                              NormalText(
                                text: "$age\n",
                                textcolor: kButtonColor,
                                weight: FontWeight.normal,
                              ),
                              NormalText(
                                text: isMale ? "$bmrMale \n" : "$bmrFemale \n",
                                textcolor: kButtonColor,
                                weight: FontWeight.normal,
                              ),
                              NormalText(
                                text: bmi.toStringAsFixed(2),
                                textcolor: kButtonColor,
                                weight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        _showEditModal(context, userData);
                      },
                      child: const LeftIconWithText(
                        icon_name: Icons.edit_note_outlined,
                        text: 'Edit',
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: const LeftIconWithText(
                      icon_name: Icons.logout_outlined,
                      text: 'Logout',
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _showEditModal(BuildContext context, Map<String, dynamic> userData) {
    TextEditingController heightController = TextEditingController(text: userData['height'].toString());
    TextEditingController weightController = TextEditingController(text: userData['weight'].toString());
    TextEditingController ageController = TextEditingController(text: userData['age'].toString());
    String gender = userData['gender'];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: gender,
                    items: ['male', 'female']
                        .map((label) => DropdownMenuItem(
                      value: label,
                      child: Text(label),
                    ))
                        .toList(),
                    onChanged: (value) {
                      gender = value!;
                    },
                    decoration: const InputDecoration(labelText: 'Gender'),
                  ),

                  TextField(
                    controller: heightController,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: weightController,
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _updateUserData(
                          height: int.parse(heightController.text),
                          weight: int.parse(weightController.text),
                          age: int.parse(ageController.text),
                          gender: gender,
                        );
                        Navigator.pop(context);
                      });
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateUserData({required int height, required int weight, required int age, required String gender}) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    final userData = {
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
    };

    FirebaseFirestore.instance.collection('users').doc(userId).update(userData)
        .then((value) => print("User data updated successfully"))
        .catchError((error) => print("Failed to update user data: $error"));
  }
}

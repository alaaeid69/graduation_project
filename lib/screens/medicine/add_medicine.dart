import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/screens/medicine/CounterView%20.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/custom_textfield.dart';
import '../../theme/constants.dart';
import '../../widgets/text.dart';

class Add_med extends StatefulWidget {
  @override
  _Add_medState createState() => _Add_medState();
}

class _Add_medState extends State<Add_med> {
  TextEditingController pillNameController = TextEditingController();
  List<TimeOfDay> selectedTimes = [];
  double dosage = 0;

  void addTime(TimeOfDay time) {
    setState(() {
      selectedTimes.add(time);
    });
  }

  void updateDosage(double newDosage) {
    setState(() {
      dosage = newDosage;
    });
  }

  Future<void> saveMedicine() async {
    String pillName = pillNameController.text;

    if (pillName.isNotEmpty && selectedTimes.isNotEmpty && dosage > 0) {
      // Convert times to a readable format
      List<String> times =
          selectedTimes.map((time) => time.format(context)).toList();

      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;

        // Reference to the user's document in the "medicine" collection
        DocumentReference userDoc =
            FirebaseFirestore.instance.collection('medicine').doc(userId);

        // Check if the document already exists
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          // If the document exists, update the existing array of medicines
          userDoc.update({
            'medicines': FieldValue.arrayUnion([
              {
                'pill_name': pillName,
                'times': times,
                'dosage': dosage,
              }
            ])
          });
        } else {
          // If the document does not exist, create a new one with the medicines array
          userDoc.set({
            'medicines': [
              {
                'pill_name': pillName,
                'times': times,
                'dosage': dosage,
              }
            ]
          });
        }

        // Clear the fields after saving
        pillNameController.clear();
        setState(() {
          selectedTimes.clear();
          dosage = 0;
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Medicine saved successfully!')));
      } catch (e) {
        // Show an error message if something goes wrong
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save medicine: $e')));
      }
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Please enter pill name, select times, and set dosage.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kButtonColor,
        title: const TextTitle(
          text: 'Add medicine',
          textcolor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Row(
                children: [
                  SubTitle(
                    text: "Pills name",
                    textcolor: Colors.black,
                    weight: FontWeight.bold,
                  )
                ],
              ),
              Row(
                children: [
                  CustomTextField(
                    hintText: 'Add pill name...',
                    controller: pillNameController,
                    isPassword: false,
                    padding_left: 0,
                    padding_top: 10,
                    padding_right: 0,
                    padding_bottom: 30,
                  )
                ],
              ),
              Row(
                children: [
                  const SubTitle(
                    text: "Dosage",
                    textcolor: Colors.black,
                    weight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: CounterScreen(
                      onDosageChanged: updateDosage,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(kButtonColor),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          builder: (context, child) => Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: kButtonColor,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: kButtonColor,
                                  onBackground: Colors.white,
                                  onSecondary: Colors.white,
                                  secondary: kButtonColor,
                                ),
                                cardColor: kButtonColor,
                                primaryColor: kButtonColor),
                            child: child!,
                          ),
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          addTime(pickedTime);
                        }
                      },
                      child: selectedTimes.isEmpty
                          ? const Text("Add Time")
                          : const Text("Add Another Time"),
                    ),
                  ],
                ),
              ),
              selectedTimes.isEmpty
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          SubTitle(
                            text: "Time of dosages",
                            textcolor: Colors.black,
                            weight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
              ...selectedTimes
                  .map((time) => Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              NormalText(
                                text: "${selectedTimes.indexOf(time) + 1}-",
                                textcolor: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              Text(
                                time.format(context),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              selectedTimes.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: CalculateButton(
                        title: 'Save',
                        onTap: saveMedicine,
                        buttonbackcolor: kButtonColor,
                        buttontextcolor: Colors.white,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/calender.dart';
import 'package:gradproj/widgets/custom_textfield.dart';
import 'package:gradproj/widgets/custom_timepicker&cupertinoPicker.dart';
import 'package:gradproj/widgets/dropdownlist.dart';
import '../../theme/constants.dart';
import '../../widgets/text.dart';

class A1cPLUS extends StatefulWidget {
  const A1cPLUS({super.key});

  @override
  State<A1cPLUS> createState() => _A1cPLUSState();
}

List<String> a1c_items = ["1", "2", "3", "4", "5", "6"];
int index = 0;

class _A1cPLUSState extends State<A1cPLUS> {
  TextEditingController a1c_controller = TextEditingController();
  TextEditingController eAg_controller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedDuration = '3';

  Future<void> saveA1cData() async {
    String a1c = a1c_controller.text;
    String eAg = eAg_controller.text;

    if (a1c.isNotEmpty && eAg.isNotEmpty) {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;

        // Reference to the user's document in the "A1C" collection
        DocumentReference userDoc =
            FirebaseFirestore.instance.collection('A1C').doc(userId);

        // Check if the document already exists
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          // If the document exists, update the existing array of A1C data
          userDoc.update({
            'tests': FieldValue.arrayUnion([
              {
                'a1c_percentage': a1c,
                'eAg_percentage': eAg,
                'date':
                    '${selectedDate.month}-${selectedDate.day}-${selectedDate.year}',
                'time': selectedTime.format(context),
                'duration': selectedDuration,
              }
            ])
          });
        } else {
          // If the document does not exist, create a new one with the A1C data array
          userDoc.set({
            'tests': [
              {
                'a1c_percentage': a1c,
                'eAg_percentage': eAg,
                'date':
                    '${selectedDate.month}-${selectedDate.day}-${selectedDate.year}',
                'time': selectedTime.format(context),
                'duration': selectedDuration,
              }
            ]
          });
        }

        // Clear the fields after saving
        a1c_controller.clear();
        eAg_controller.clear();
        setState(() {
          selectedDate = DateTime.now();
          selectedTime = TimeOfDay.now();
          selectedDuration = '3';
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('A1C data saved successfully!')));
      } catch (e) {
        // Show an error message if something goes wrong
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save A1C data: $e')));
      }
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Please enter A1C and eAg percentages.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kButtonColor,
        title: const TextTitle(
          text: 'A1C',
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
                    text: 'A1C percentage',
                    textcolor: Colors.black,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomTextField(
                    hintText: '',
                    controller: a1c_controller,
                    isPassword: false,
                    padding_left: 0,
                    padding_top: 15,
                    padding_right: 0,
                    padding_bottom: 15,
                  ),
                ],
              ),
              const Row(
                children: [
                  SubTitle(
                    text: 'eAg percentage',
                    textcolor: Colors.black,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomTextField(
                    hintText: '',
                    controller: eAg_controller,
                    isPassword: false,
                    padding_left: 0,
                    padding_top: 15,
                    padding_right: 0,
                    padding_bottom: 0,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    SubTitle(
                      text: 'Date',
                      textcolor: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Calender(
                    onDateChanged: (newDate) {
                      setState(() {
                        selectedDate = newDate;
                      });
                    },
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    SubTitle(
                      text: 'Time',
                      textcolor: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    CustomTimePicker(
                      cancle_text: 'Cancel',
                      onTimeChanged: (newTime) {
                        setState(() {
                          selectedTime = newTime;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    SubTitle(
                      text: 'Duration between each test',
                      textcolor: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CustomDropDownlist(
                      items: a1c_items,
                      month_or_year: ' months',
                      selected: selectedDuration,
                      onChanged: (newValue) {
                        setState(() {
                          selectedDuration = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CalculateButton(
                  title: 'Save',
                  onTap: saveA1cData,
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

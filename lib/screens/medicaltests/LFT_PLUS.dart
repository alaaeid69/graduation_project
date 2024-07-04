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

class LFT_PLUS extends StatefulWidget {
  const LFT_PLUS({super.key});

  @override
  State<LFT_PLUS> createState() => _LFT_PLUSState();
}

List<String> lft_items = ["1", "2", "3", "4", "5", "6"];
int index = 0;

class _LFT_PLUSState extends State<LFT_PLUS> {
  TextEditingController alt_controller = TextEditingController();
  TextEditingController ast_controller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedDuration = '3';

  Future<void> saveLFTData() async {
    String alt = alt_controller.text;
    String ast = ast_controller.text;

    if (alt.isNotEmpty && ast.isNotEmpty) {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;

        // Reference to the user's document in the "A1C" collection
        DocumentReference userDoc =
        FirebaseFirestore.instance.collection('LFT').doc(userId);

        // Check if the document already exists
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          // If the document exists, update the existing array of A1C data
          userDoc.update({
            'tests': FieldValue.arrayUnion([
              {
                'ALT_percentage': alt,
                'AST_percentage': ast,
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
                'ALT_percentage': alt,
                'AST_percentage': ast,
                'date':
                '${selectedDate.month}-${selectedDate.day}-${selectedDate.year}',
                'time': selectedTime.format(context),
                'duration': selectedDuration,
              }
            ]
          },
          );
        }

        // Clear the fields after saving
        alt_controller.clear();
        ast_controller.clear();
        setState(() {
          selectedDate = DateTime.now();
          selectedTime = TimeOfDay.now();
          selectedDuration = '3';
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('LFT data saved successfully!')));
      } catch (e) {
        // Show an error message if something goes wrong
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save LFT data: $e')));
      }
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,

              content: Text('Please enter LFT and eAg percentages.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kButtonColor,
        title: const TextTitle(
          text: 'LFT',
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
                    text: 'ALT_percentage',
                    textcolor: Colors.black,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomTextField(
                    hintText: '',
                    controller: alt_controller,
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
                    text: 'AST_percentage',
                    textcolor: Colors.black,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomTextField(
                    hintText: '',
                    controller: ast_controller,
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
                      items: lft_items,
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
                  onTap: saveLFTData,
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

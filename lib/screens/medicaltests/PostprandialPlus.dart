import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/calender.dart';
import 'package:gradproj/widgets/custom_textfield.dart';
import 'package:gradproj/widgets/custom_timepicker&cupertinoPicker.dart';
import '../../theme/constants.dart';
import '../../widgets/text.dart';

class PostprandialPlus extends StatefulWidget {
  const PostprandialPlus({super.key});

  @override
  State<PostprandialPlus> createState() => _PostprandialPlusState();
}
int index=0;
class _PostprandialPlusState extends State<PostprandialPlus> {
  TextEditingController bloodSugarController = TextEditingController();
  int index = 0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> savePostprandialData() async {
    String bloodSugar = bloodSugarController.text;


    if (bloodSugar.isNotEmpty) {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;

        // Reference to the user's document in the "A1C" collection
        DocumentReference userDoc =
        FirebaseFirestore.instance.collection('postprandial').doc(userId);

        // Check if the document already exists
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          // If the document exists, update the existing array of A1C data
          userDoc.update({
            'tests': FieldValue.arrayUnion([
              {
                'bloodSugar': bloodSugar,

                'date':
                '${selectedDate.month}-${selectedDate.day}-${selectedDate.year}',
                'time': selectedTime.format(context),
              }
            ])
          });
        } else {
          // If the document does not exist, create a new one with the A1C data array
          userDoc.set({
            'tests': [
              {
                'bloodSugar': bloodSugar,
                'date':
                '${selectedDate.month}-${selectedDate.day}-${selectedDate.year}',
                'time': selectedTime.format(context),
              }
            ]
          });
        }

        // Clear the fields after saving
        bloodSugarController.clear();

        setState(() {
          selectedDate = DateTime.now();
          selectedTime = TimeOfDay.now();
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('postprandial data saved successfully!')));
      } catch (e) {
        // Show an error message if something goes wrong
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save postprandial data: $e')));
      }
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Please enter BloodSugar percentage.')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: kButtonColor,
            title: const TextTitle(
              text: 'Postprandal blood',
              textcolor: Colors.white,
            )
        ),
        body:  SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Row(
                        children: [
                          SubTitle(
                            text: 'Blood sugar percentage',
                            textcolor: Colors.black,
                            weight: FontWeight.bold,
                          )
                        ]),
                    Row(
                        children: [
                          CustomTextField(
                            hintText: '',
                            controller: bloodSugarController,
                            isPassword: false,
                            padding_left: 0,
                            padding_top: 15,
                            padding_right: 0,
                            padding_bottom: 15,
                          )]),
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                          children: [
                            SubTitle(
                                text: 'Date',
                                textcolor: Colors.black,
                                weight: FontWeight.bold
                            ),
                          ]),
                    ),
                    Row(
                        children: [
                          Calender(onDateChanged: (value) {
                            
                          },),
                        ]),
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                          children: [
                            SubTitle(
                                text: 'Time',
                                textcolor: Colors.black,
                                weight: FontWeight.bold
                            ),
                          ]),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                            children: [
                              CustomTimePicker(cancle_text: 'Cancel', onTimeChanged: (TimeOfDay value) {  },),
                            ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: CalculateButton(
                            title: 'Save',
                            onTap: savePostprandialData,
                            buttonbackcolor: kButtonColor,
                            buttontextcolor: Colors.white
                        ))
                  ],
                )
            )));
  }
}


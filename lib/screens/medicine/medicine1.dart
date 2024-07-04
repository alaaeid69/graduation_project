import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/core/widgets/style.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:gradproj/widgets/button.dart';
import 'package:gradproj/widgets/cards.dart';
import 'package:gradproj/widgets/custom_checkbox.dart';
import 'package:gradproj/widgets/text.dart';
import '../../widgets/icons.dart';
import '../../widgets/image.dart';
import 'add_medicine.dart';

class Medicine extends StatefulWidget {
  const Medicine({super.key});

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopImage(
        imagesrc: 'images/medicinebackimg.jpg',
        widget: medWidget(),
        title: 'Medicine',
      ),
    );
  }

  Widget medWidget() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: TextTitle(
            text: 'Daily review',
            textcolor: kButtonColor,
          ),
        ),
        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('medicine')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.data!.exists) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'No medicine data found,\nplease add a new medicine.',
                    style: Styles.textStyle18,
                  ),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.data() == null) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'No medicine data found,\nplease add a new medicine.',
                    style: Styles.textStyle18,
                  ),
                ),
              );
            }

            var medicines = snapshot.data!['medicines'] as List<dynamic>;
            return SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  var medicine = medicines[index];
                  return CustomCard(
                    card_content: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SubTitle(
                                text: medicine['pill_name'],
                                textcolor: Colors.black,
                                weight: FontWeight.normal,
                              ),
                              const Spacer(flex: 1),
                              SmallIcon(
                                icon_name: Icons.delete,
                                action: () async {
                                  await _deleteMedicine(index);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 170,
                            child: Column(
                              children: List<Widget>.generate(
                                (medicine['times'] as List<dynamic>).length,
                                (timeIndex) => CustomCheckbox(
                                  checkbox_title: medicine['times'][timeIndex],
                                  checkboxtitle_widget: SmallText(
                                    text: medicine['times'][timeIndex],
                                    textcolor: Colors.black,
                                    weight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: SmallText(
                                  text: 'Dosage: ${medicine['dosage']}',
                                  textcolor: Colors.black,
                                  weight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    card_height: 320,
                    card_action: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Add_med(),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: CalculateButton(
            title: 'Add new medicine',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (e) => Add_med()),
              );
            },
            buttonbackcolor: kButtonColor,
            buttontextcolor: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> _deleteMedicine(int index) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('medicine').doc(userId);

    // Get the current document
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      List<dynamic> medicines = doc['medicines'];

      // Remove the medicine at the specified index
      medicines.removeAt(index);

      // Update the document
      await docRef.update({'medicines': medicines});
    }
  }
}

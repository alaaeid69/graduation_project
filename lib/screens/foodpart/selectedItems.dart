import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradproj/theme/constants.dart';
import '../../widgets/cards.dart';
import '../../widgets/text.dart';

class SelectedItems extends StatefulWidget {
  const SelectedItems({Key? key}) : super(key: key);

  @override
  _SelectedItemsState createState() => _SelectedItemsState();
}

class _SelectedItemsState extends State<SelectedItems> {
  int _totalKcal = 0;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {

      // Return a message or alternative UI if user is not logged in
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kButtonColor,
          foregroundColor: Colors.white,
          title: const TextTitle(
            text: 'Selected items',
            textcolor: Colors.white,
          ),
        ),
        body: const Center(
          child: Text(
            'Please log in to view selected items',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kButtonColor,
        foregroundColor: Colors.white,
        title: const TextTitle(
          text: 'Selected items',
          textcolor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('selected_items')
                  .doc(userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('No selected items'));
                }
                var selectedItems = List<Map<String, dynamic>>.from(snapshot.data!['items']);
                _totalKcal = selectedItems.fold<int>(0, (total, item) {
                  final kcal = item['kcal'];
                  if (kcal is num) {
                    final kcalInt = int.tryParse(kcal.toString());
                    if (kcalInt != null) {
                      return total + kcalInt;
                    }
                  }
                  return total;
                });



                var userData = snapshot.data?.data() as Map<String, dynamic>;
                bool isMale = userData['gender'] == 'male';
                print(isMale);
                num height = userData['height'];
                num weight = userData['weight'];
                num age = userData['age'];
                var bmrMale = (10 * weight.toDouble()) + (6.25 * height.toDouble()) - (5 * age) + 5;
                var bmrFemale = (10 * weight.toDouble()) + (6.25 * height.toDouble()) - (5 * age) - 161;
                num bmr = isMale ? bmrMale : bmrFemale;
                var remaining = bmr - _totalKcal ;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      color: const Color(0xff0861E7),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 60, top: 30),
                              child: Row(
                                children: [
                                  SubTitle(
                                    text: "Eaten",
                                    textcolor: Colors.white,
                                    weight: FontWeight.bold,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 100),
                                    child: SubTitle(
                                      text: "Remaining",
                                      textcolor: Colors.white,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  CustomCard(
                                    card_action: () {},
                                    card_height: 50,
                                    card_content: Padding(
                                      padding: const EdgeInsets.fromLTRB(25, 8, 25, 0),
                                      child: SmallText(
                                        textcolor: Colors.black,
                                        text: '$_totalKcal kcal',
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  CustomCard(
                                    card_action: () {},
                                    card_height: 50,
                                    card_content:  Padding(
                                      padding: const EdgeInsets.fromLTRB(25, 8, 25, 0),
                                      child: SmallText(
                                        textcolor: Colors.black,
                                        text: "$remaining" ?? '',
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    for (var item in selectedItems)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SubTitle(
                              text: item['name'],
                              textcolor: Colors.black,
                              weight: FontWeight.bold,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outlined),
                              onPressed: () {
                                _removeItemFromSelectedItems(userId, item);
                              },
                            ),
                            SmallText(
                              text: '${item['kcal']} kcal',
                              textcolor: Colors.black,
                              weight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _removeItemFromSelectedItems(String userId, Map<String, dynamic> item) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('selected_items').doc(userId);

      await docRef.update({
        'items': FieldValue.arrayRemove([item]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item removed from selected items')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: $e')),
      );
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/screens/foodpart/search_field.dart';

import '../../theme/constants.dart';
import '../../widgets/button.dart';

class BreakfastScreen extends StatefulWidget {
  const BreakfastScreen({super.key});

  @override
  BreakfastScreenState createState() => BreakfastScreenState();
}

class BreakfastScreenState extends State<BreakfastScreen> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final List<Map<String, dynamic>> selectedItems = [];

  void _addSelectedItems() async {
    if (selectedItems.isNotEmpty) {
      DocumentReference userSelectedItemsDoc =
          FirebaseFirestore.instance.collection('selected_items').doc(userId);

      await userSelectedItemsDoc.set(
          {'items': FieldValue.arrayUnion(selectedItems)},
          SetOptions(merge: true));

      setState(() {
        selectedItems.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selected items added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Breakfast',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0, // Remove the bar under the title bar
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _addSelectedItems,
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('breakfast').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    var breakfast = snapshot.data?.docs[index];
                    var name = breakfast?['name'];
                    var kcal = breakfast?['kcal'];
                    var image = breakfast?['image'];
                    var desc = breakfast?['desc'];
                    var id = breakfast!.id;

                    return BreakFastListViewItem(
                      id: id,
                      name: name,
                      kcal: kcal,
                      image: image,
                      desc: desc,
                      onChecked: (isChecked) {
                        if (isChecked) {
                          selectedItems.add({
                            'name': name,
                            'kcal': kcal,
                          });
                        } else {
                          selectedItems.removeWhere((item) => item['id'] == id);
                        }
                      },
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: CalculateButton(
              title: 'Add another food',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (v) => const SearchField()));
              },
              buttonbackcolor: kButtonColor,
              buttontextcolor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class BreakFastListViewItem extends StatefulWidget {
  const BreakFastListViewItem({
    Key? key,
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.kcal,
    required this.onChecked,
  }) : super(key: key);

  final String id, name, desc, image;
  final num kcal;
  final Function(bool) onChecked;

  @override
  _BreakFastListViewItemState createState() => _BreakFastListViewItemState();
}

class _BreakFastListViewItemState extends State<BreakFastListViewItem> {
  bool isChecked = false;

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value!;
    });
    widget.onChecked(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Checkbox(
                  value: isChecked,
                  onChanged: _onCheckboxChanged,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.desc,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                Image.network(
                  widget.image,
                  height: 90,
                  width: 90,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Calories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${widget.kcal} cal',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

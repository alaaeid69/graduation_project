import 'package:flutter/material.dart';
import 'package:gradproj/screens/foodpart/search_field.dart';
import 'package:gradproj/widgets/button.dart';

import '../../theme/constants.dart';
import '../../widgets/cards.dart';
import '../../widgets/custom_checkbox.dart';
import '../../widgets/text.dart';

class Meals extends StatefulWidget {
  late int pageIndex;

  Meals({Key? myKey, required this.pageIndex}) : super(key: myKey);

  @override
  State<Meals> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<Meals> {
  bool? isChecked = false;
  final List<String> breakfast_cardtitle = [
    'French Toast',
    'Egg and Vegetables',
    'Yogurt and Fruits'
  ];
  final List<String> breakfast_desc = [
    'mix 1 egg ,1/4 cup\nof skim milk,teaspoon\nof vanilla and 1/2\nteaspoon of\ncinnamon.'
        'soak 2\nslides of toast in\nthis mixture then\nfry the bread in\nthe pan .',
    '2 slices of bread\n1 egg omelet\nvegetables salad\nspoonful of cheese2\ntablespoon of avocado',
    'yogurt + seasonal\nfruits or honey\nor molasses'
  ];
  final List<String> breakfast_image = [
    'images/bread.png',
    'images/egg.png',
    'images/yogurt.png'
  ];
  final List<String> breakfast_cal = ['250', '500', '500'];

  final List<String> lunch_cardtitle = [
    'Tuna Salad',
    'Grilled Fish or Chicken',
    'Legume soup and Salad'
  ];
  final List<String> lunch_desc = [
    'can of tuna +\nany vegetables\nyou want.',
    'fish or chicken\nbreast + green salad +\ntablespoon of rice.',
    'lentils or peas or\nbeans or any\nlegume soup +\nvegetables salad'
  ];
  final List<String> lunch_image = [
    'images/tunasalad.png',
    'images/fish.png',
    'images/soup.png'
  ];
  final List<String> lunch_cal = ['230', '600', '400'];

  final List<String> dinner_cardtitle = ['Pizza', 'Yogurt and Fruits'];
  final List<String> dinner_desc = [
    '2 slices of pizza\n+ vegetables salad',
    'yogurt + seasonal\nfruits or honey\nor molasses'
  ];
  final List<String> dinner_image = ['images/pizza.png', 'images/yogurt.png'];
  final List<String> dinner_cal = ['600', '500'];

  final List<String> snacks_cardtitle = [
    'A handful of rawalmond',
    'Dark Chocolate'
  ];
  final List<String> snacks_desc = [
    '',
    '2 cubes of chocolate\nwith 70% cocoa (100 g)'
  ];
  final List<String> snacks_image = ['images/nuts.png', 'images/chocolate.png'];
  final List<String> snacks_cal = ['170', '581'];

  int _currentIndex = 0;
  late int number_of_cards;
  late String pagetitle;
  late List<String> cardtitle;
  late List<String> carddesc;
  late List<String> cardimage;
  late List<String> cardcal;
  List<bool> _isChecked = List<bool>.filled(3, false);

  @override
  Widget build(BuildContext context) {
    if (widget.pageIndex == 0) {
      pagetitle = 'Breakfast';
      number_of_cards = breakfast_cardtitle.length;
      cardtitle = breakfast_cardtitle;
      carddesc = breakfast_desc;
      cardimage = breakfast_image;
      cardcal = breakfast_cal;
    } else if (widget.pageIndex == 1) {
      pagetitle = 'Lunch';
      number_of_cards = lunch_cardtitle.length;
      cardtitle = lunch_cardtitle;
      carddesc = lunch_desc;
      cardimage = lunch_image;
      cardcal = lunch_cal;
    } else if (widget.pageIndex == 2) {
      pagetitle = 'Dinner';
      number_of_cards = dinner_cardtitle.length;
      cardtitle = dinner_cardtitle;
      carddesc = dinner_desc;
      cardimage = dinner_image;
      cardcal = dinner_cal;
    } else if (widget.pageIndex == 3) {
      pagetitle = 'Snacks';
      number_of_cards = snacks_cardtitle.length;
      cardtitle = snacks_cardtitle;
      carddesc = snacks_desc;
      cardimage = snacks_image;
      cardcal = snacks_cal;
    }

    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
        TextTitle(
          text: pagetitle,
          textcolor: Colors.black,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 130),
            child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.save,
                )))
      ])),
      body: _MealsWidget(),
    );
  }

  Widget _MealsWidget() {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: number_of_cards,
          itemBuilder: (context, index) {
            _currentIndex = index;
            return CustomCard(
                card_action: () {},
                card_height: 385,
                card_content: Column(children: [
                  CustomCheckbox(
                    checkbox_title: cardtitle[_currentIndex],
                    checkboxtitle_widget: NormalText(
                      text: cardtitle[_currentIndex],
                      weight: FontWeight.bold,
                      textcolor: Colors.black,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(children: [
                        Row(
                          children: [
                            SmallText(
                              text: carddesc[_currentIndex],
                              textcolor: Colors.black,
                              weight: FontWeight.normal,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Image.asset(
                              cardimage[_currentIndex],
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Row(
                              children: [
                                const SmallText(
                                  text: 'Calories',
                                  textcolor: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 100),
                                    child: SmallText(
                                      text: cardcal[_currentIndex] + ' cal',
                                      textcolor: Colors.black,
                                      weight: FontWeight.bold,
                                    )),
                              ],
                            ))
                      ]))
                ]));
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: CalculateButton(
            title: 'Add another food',
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (v) => const SearchField()));
            },
            buttonbackcolor: kButtonColor,
            buttontextcolor: Colors.white),
      ),
    ]);
  }
}

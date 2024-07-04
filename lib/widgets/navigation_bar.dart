import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../theme/constants.dart';


class NavigationBarGNav extends StatelessWidget{

   NavigationBarGNav({
    super.key,
    required this.showhomewidget,
    required this.showreportwidget,
    required this.showsettingswidget,
  });
  VoidCallback showhomewidget;
  VoidCallback showreportwidget;
  VoidCallback showsettingswidget;
  @override
  Widget build(BuildContext context) {
   return Container(
     color: Colors.white,
     child: Padding(
       padding: const EdgeInsets.all(10),
       child: GNav(
         color: Color.fromRGBO(145, 143, 143, 1.0),
           activeColor: kButtonColor,
           backgroundColor: Colors.white,
           tabBackgroundColor: Color.fromRGBO(8, 97, 231, 0.14901960784313725),
           padding: EdgeInsets.all(10),
           gap: 8,
           tabs: [
             GButton(
               onPressed: showhomewidget,
                 active: true,
                 text: 'Home',
                 icon: Icons.home
             ),
             GButton(
               onPressed: showreportwidget,
                 icon: Icons.timeline,
                 text: 'Report',
             ),
             GButton(
               onPressed: showsettingswidget,
                 icon: Icons.settings,
                 text: 'Settings',
             ),
           ]
       ),
     ),
   );
  }

}
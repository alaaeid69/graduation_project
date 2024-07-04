import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradproj/screens/main_screens/settings.dart';
import 'package:gradproj/screens/reports/reports.dart';
import 'package:gradproj/widgets/navigation_bar.dart';
import 'package:intl/intl.dart';

import '../../core/widgets/style.dart';
import 'homepage.dart';

 class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
  }

   class _MainPageState extends State<MainPage> {
   Widget _homeWidget = HomePageScreen();

   Future<bool> onWillPop() async {
     bool type = false;
     await Future.delayed(
       Duration.zero,
           () {
         showDialog(
           context: context,
           builder: (BuildContext context) {
             return AlertDialog(
               backgroundColor: Colors.white,
               title: Text(
                 'Are you sure to close the app?',
                 style:
                 Styles.textStyle22.copyWith(fontWeight: FontWeight.w500),
                 textAlign: TextAlign.end,
               ),
               actions: [
                 TextButton(
                     onPressed: () {
                       type = false;
                       Navigator.pop(context);
                     },
                     child: const Text('No', style: Styles.textStyle16)),
                 TextButton(
                     onPressed: () {
                       type = true;
                       SystemNavigator.pop();
                     },
                     child: const Text(
                       'Yes',
                       style: Styles.textStyle16,
                     )),
               ],
             );
           },
         );
       },
     );
     return type;
   }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: _homeWidget,
          bottomNavigationBar: NavigationBarGNav(
            showhomewidget: () {
              setState(() {
                _homeWidget = HomePageScreen();
              });
            },
            showreportwidget: () {
              setState(() {
                _homeWidget = Reports();
              });
            },
            showsettingswidget: () {
              setState(() {
                _homeWidget = Settings();
              });
            },
          )),
    );
  }
}

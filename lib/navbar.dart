import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hostelhive_admin/notices.dart';
//import 'package:final_minor/complaints.dart';
//import 'package:final_minor/notice.dart';
//import 'package:final_minor/settings_page.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _index =0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  var screens =[ notices()
    //notice(),Complaints(),SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: Container(
        height: 55,
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: Colors.white,
          color: Colors.amberAccent,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            Icon((_index==0) ? Icons.tips_and_updates_outlined: Icons.tips_and_updates, size: 30, color: Colors.black,),
            Icon((_index==1) ? Icons.rate_review_outlined : Icons.rate_review, size: 30, color: Colors.black,),
            Icon((_index==2) ? Icons.settings_outlined : Icons.settings, size: 30, color: Colors.black,),
          ],
          index: _index,
          onTap: (selectedIndex) {
            setState(() {
              _index= selectedIndex;
            });
          },
        ),
      ),
    );
  }
}

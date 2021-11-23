import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: darkBlue,
      selectedItemColor: lightBlue,
      unselectedItemColor: blue,
      currentIndex: 0,
      onTap: (deneme) {},
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.white,
      selectedFontSize: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.last_page),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_phone),
          label: '',
        ),
      ],
    );
  }
}

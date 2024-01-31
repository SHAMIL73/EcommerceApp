
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Const/Color.dart';
import 'package:flutter_application_2/Controller/DarkModeGetx.dart';
import 'package:flutter_application_2/View/Cart.dart';
import 'package:flutter_application_2/View/Eapp.dart';
import 'package:flutter_application_2/View/Profile.dart';
import 'package:flutter_application_2/View/Wishlist.dart';
import 'package:get/get.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Eapp(),
    const Wishlist(),
    const CartPage(),
    const ProfilePage(),
  ];

late Color textColor;

  @override
  void initState() {
    super.initState();
    Get.put(DarkModeGetx());
    updateThemeColors();
  }

  void updateThemeColors() {
    setState(() {
      getTextColor();
    });
  }

  Color getTextColor() {
    return Get.find<DarkModeGetx>().isDarkMode ? whitecolor : blackcolor;
  }

  Color getTextColor2() {
    return Get.find<DarkModeGetx>().isDarkMode ? blackcolor : whitecolor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(backgroundColor: Color.fromARGB(255, 94, 89, 89),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trolley),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

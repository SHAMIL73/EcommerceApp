
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Controller/Getx/DarkModeGetx.dart';
import 'package:flutter_application_2/View/UI/Cart.dart';
import 'package:flutter_application_2/View/UI/Eapp.dart';
import 'package:flutter_application_2/View/UI/Order.dart';
import 'package:flutter_application_2/View/UI/Profile.dart';
import 'package:flutter_application_2/View/UI/Wishlist.dart';
import 'package:get/get.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Eapp(),
    const Wishlist(),
    const CartPage(),
    const Orderpage(),
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
    return Get.find<DarkModeGetx>().isDarkMode ? Colors.white : Colors.black;
  }

  Color getTextColor2() {
    return Get.find<DarkModeGetx>().isDarkMode ? Colors.black : Colors.white;
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
        items: const [
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
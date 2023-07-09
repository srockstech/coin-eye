import 'package:flutter/material.dart';

class BottomNavigationMenu extends StatelessWidget {
  final double screenWidth;
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavigationMenu({
    this.screenWidth,
    this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      iconSize: screenWidth * 0.07,
      selectedFontSize: screenWidth * 0.025,
      unselectedFontSize: screenWidth * 0.025,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}

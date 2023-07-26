import 'package:flutter/material.dart';

class BottomNavigationMenu extends StatelessWidget {
  final double? screenWidth;
  final int selectedIndex;
  final Function(int)? onTap;

  const BottomNavigationMenu({
    this.screenWidth,
    required this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue[600],
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      iconSize: screenWidth! * 0.07,
      selectedFontSize: screenWidth! * 0.027,
      unselectedFontSize: screenWidth! * 0.027,
      currentIndex: selectedIndex,
      elevation: 15,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.currency_bitcoin_sharp,
          ),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.alternate_email_sharp,
          ),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chrome_reader_mode_sharp,
            size: screenWidth! * 0.11,
          ),
          label: 'Learn',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.leaderboard_outlined,
          ),
          label: 'Leaderboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.wallet_sharp,
          ),
          label: 'Wallet',
        ),
      ],
    );
  }
}

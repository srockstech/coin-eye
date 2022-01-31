import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'all_coins_list.dart';
import 'utilities/constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 5,
        shadowColor: Color(0xFF000000),
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text(
              'coin',
              style: kLogoFirstWordTextStyle,
            ),
            Text(
              'eye',
              style: kLogoSecondWordTextStyle,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.attach_money_rounded,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
        bottom: TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicatorColor: Color(0xFF2BFFF1),
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'All Coins',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'My Watchlist',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AllCoinsList(),
          Center(
            child: Container(
              margin: EdgeInsets.all(50),
              child: Text(
                'You have not added any coin to your watchlist.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

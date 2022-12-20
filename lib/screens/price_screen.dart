import 'package:coin_eye/utilities/field_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/coin_data.dart';
import '../utilities/coin_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  String selectedCurrencySymbol = '\$';
  String selectedCurrencyCode = 'USD';
  Widget allCoinsTab;
  Widget selectedCurrencyIcon;
  var coinsData;
  CoinData coinData;

  // bool updatePrice = false;

  List<PopupMenuItem<String>> getPopupMenuItemsList() {
    List<PopupMenuItem<String>> popupMenuItems = [];
    currenciesList.forEach((key, value) {
      PopupMenuItem<String> popupMenuItem = PopupMenuItem(
        child: Text('$value $key'),
        value: key,
      );
      popupMenuItems.add(popupMenuItem);
    });
    return popupMenuItems;
  }

  void updateUI() async {
    for (;;) {
      coinData = CoinData(currency: selectedCurrencyCode);
      coinsData = await coinData.fetchCoinsMetaData();
      setState(() {
        allCoinsTab = Column(
          children: <Widget>[
            FieldBanner(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (listViewContext, index) {
                  var priceInString, coins24HChangeInString;
                  double price =
                      coinData.getCoinsPrice().values.toList()[index];
                  if (price < 1) {
                    priceInString = price.toStringAsFixed(6);
                  } else {
                    priceInString = price.toStringAsFixed(2);
                  }

                  double coin24HChange =
                      coinData.getCoins24Change().values.toList()[index];
                  coins24HChangeInString = coin24HChange.toStringAsFixed(2);

                  return CoinCard(
                    coinName: coinData.getCoinsName().values.toList()[index],
                    coinCode: coinData.getCoinsName().keys.toList()[index],
                    rate: priceInString,
                    percent24HChange: coins24HChangeInString,
                    selectedCurrencyCode: selectedCurrencyCode,
                    logoUrl: coinsData['data'][coinData
                        .getCoinsName()
                        .keys
                        .toList()[index]
                        .toUpperCase()][0]['logo'],
                  );
                },
                itemCount: coinData.getCoinsName().length,
              ),
            ),
          ],
        );
        selectedCurrencyIcon = Text(
          selectedCurrencySymbol,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        );
      });
      await Future.delayed(Duration(seconds: 30));
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    allCoinsTab = Center(
      child: SpinKitRing(
        color: Colors.black,
        size: 30,
        lineWidth: 4,
      ),
    );
    selectedCurrencyIcon = Text(
      selectedCurrencySymbol,
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
      ),
    );
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        elevation: 7,
        shadowColor: Colors.black,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text(
              'coin',
              style: TextStyle(
                height: 1,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: screenHeight * 0.038,
                letterSpacing: -1.5,
              ),
            ),
            Text(
              'eye',
              style: TextStyle(
                height: 1,
                color: Color(0xFF2BFFF1),
                shadows: <Shadow>[
                  Shadow(
                    color: Color(0xFF2BFFF1),
                    offset: Offset(0, 0),
                    blurRadius: 5,
                  ),
                ],
                fontWeight: FontWeight.w900,
                fontSize: screenHeight * 0.038,
                letterSpacing: -1.5,
              ),
            ),
          ],
        ),
        actions: [
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.024,
              ),
              PopupMenuButton<String>(
                splashRadius: screenHeight * 0.03,
                itemBuilder: (BuildContext context) {
                  return getPopupMenuItemsList();
                },
                onSelected: (key) {
                  selectedCurrencySymbol = currenciesList[key];
                  selectedCurrencyCode = key;
                  setState(() {
                    selectedCurrencyIcon = SpinKitRing(
                      color: Colors.white,
                      size: screenHeight * 0.025,
                      lineWidth: 2,
                    );
                  });
                  updateUI();
                },
                icon: selectedCurrencyIcon,
              ),
            ],
          ),
          SizedBox(
            width: screenHeight * 0.02,
          ),
        ],
        bottom: TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicatorColor: Color(0xFF2BFFF1),
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'All Coins',
                style: TextStyle(
                    color: Colors.white, fontSize: screenHeight * 0.018),
              ),
            ),
            Tab(
              child: Text(
                'My Watchlist',
                style: TextStyle(
                    color: Colors.white, fontSize: screenHeight * 0.018),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          allCoinsTab,
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

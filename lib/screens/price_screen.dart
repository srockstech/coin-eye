import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../services/coin_data.dart';
import 'package:coin_eye/utilities/coin_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:coin_eye/utilities/field_banner.dart';

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

  void initialUI() async {
    coinData = CoinData(currency: selectedCurrencyCode);
    coinsData = await coinData.getCoinsMetaData();
    setState(() {
      allCoinsTab = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FieldBanner(),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (listViewContext, index) {
                var priceInString;
                // double price; //todo: get price
                // if (price < 1) {
                //   priceInString = price.toStringAsFixed(6);
                // } else {
                //   priceInString = price.toStringAsFixed(2);
                // }data.BNB[0].logo data.BTC[0].logo

                return CoinCard(
                  coinName: coinData.getCoinsName().values.toList()[index],
                  coinCode: coinData.getCoinsName().keys.toList()[index],
                  rate: '817248',
                  selectedCurrencyCode: selectedCurrencyCode,
                  logoUrl:
                      // 'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png',
                      coinsData['data'][coinData
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
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    allCoinsTab = Center(
      child: SpinKitRing(
        color: Colors.black,
        size: 50,
        lineWidth: 4,
      ),
    );
    initialUI();
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
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return getPopupMenuItemsList();
            },
            onSelected: (key) {
              selectedCurrencySymbol = currenciesList[key];
              selectedCurrencyCode = key;
              initialUI();
            },
            icon: Text(
              selectedCurrencySymbol,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 8,
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

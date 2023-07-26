import 'package:coin_eye/screens/welcome_screen.dart';
import 'package:coin_eye/utilities/bottom_navigation_menu.dart';
import 'package:coin_eye/utilities/field_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/coin_data.dart';
import '../utilities/coin_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  String selectedCurrencySymbol = '\$';
  String selectedCurrencyCode = 'USD';
  Widget? allCoinsTab;
  Widget? selectedCurrencyIcon;
  var coinsData;
  CoinData? coinData;
  bool? disposed;
  int selectedIndex = 2;

  // bool updatePrice = false;

  List<PopupMenuItem<String>> getPopupFlatCurrenciesList() {
    List<PopupMenuItem<String>> popupFlatCurrencies = [];
    currenciesList.forEach((key, value) {
      PopupMenuItem<String> popupFlatCurrency = PopupMenuItem(
        child: Text('$value $key'),
        value: key,
      );
      popupFlatCurrencies.add(popupFlatCurrency);
    });
    return popupFlatCurrencies;
  }

  List<PopupMenuItem<String>> getPopupMenuItemsList() {
    List<PopupMenuItem<String>> popupMenuItems = [
      PopupMenuItem(
        child: Text('Logout'),
        value: 'logout',
      )
    ];
    return popupMenuItems;
  }

  void updateUI() async {
    for (; disposed == false;) {
      print('fetching data from api...');
      coinData = CoinData(currency: selectedCurrencyCode);
      coinsData = await coinData!.fetchCoinsMetaData();
      setState(() {
        allCoinsTab = Column(
          children: <Widget>[
            FieldBanner(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (listViewContext, index) {
                  try {
                    var priceInString, coins24HChangeInString;
                    double price =
                        coinData!.getCoinsPrice().values.toList()[index];

                    if (price < 1) {
                      priceInString = price.toStringAsFixed(6);
                    } else {
                      priceInString = price.toStringAsFixed(2);
                    }
                    double coin24HChange =
                        coinData!.getCoins24Change().values.toList()[index];

                    coins24HChangeInString = coin24HChange.toStringAsFixed(2);

                    String logoUrl = coinsData['data'][coinData!
                        .getCoinsName()
                        .keys
                        .toList()[index]
                        .toUpperCase()][0]['logo'];

                    String coinName;
                    coinName = coinData!.getCoinsName().values.toList()[index];

                    String coinCode;
                    coinCode = coinData!.getCoinsName().keys.toList()[index];

                    return CoinCard(
                      coinName: coinName,
                      coinCode: coinCode,
                      rate: priceInString,
                      percent24HChange: coins24HChangeInString,
                      selectedCurrencyCode: selectedCurrencyCode,
                      logoUrl: logoUrl,
                    );
                  } catch (e) {
                    return Center(
                      child: SpinKitThreeBounce(
                        color: Colors.grey[200],
                        size: 30,
                      ),
                    );
                  }
                },
                itemCount: coinData!.getCoinsName().length,
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
    disposed = false;
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
        color: Colors.black,
        fontSize: 23,
        fontWeight: FontWeight.w500,
      ),
    );
    updateUI();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationMenu(
          screenWidth: screenWidth,
          selectedIndex: selectedIndex,
          onTap: (index) {
            if (index != selectedIndex) {
              setState(() {
                selectedIndex = index;
              });
            }
          },
        ),
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.1,
          elevation: 7,
          shadowColor: Colors.grey[100],
          backgroundColor: Colors.black,
          titleSpacing: 0,
          title: Column(
            children: [
              Text(
                'Market',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: screenHeight * 0.03,
                ),
              ),
            ],
          ),
          leadingWidth: screenWidth * 0.2,
          leading: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.024,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6),
                ),
                width: screenWidth * 0.105,
                height: screenWidth * 0.105,
                child: PopupMenuButton<String>(
                  splashRadius: screenHeight * 0.03,
                  itemBuilder: (BuildContext context) {
                    return getPopupMenuItemsList();
                  },
                  onSelected: (key) {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                PopupMenuButton<String>(
                  splashRadius: screenHeight * 0.03,
                  itemBuilder: (BuildContext context) {
                    return getPopupFlatCurrenciesList();
                  },
                  onSelected: (key) {
                    selectedCurrencySymbol = currenciesList[key]!;
                    selectedCurrencyCode = key;
                    setState(() {
                      selectedCurrencyIcon = SpinKitRing(
                        color: Colors.white,
                        size: screenHeight * 0.03,
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
            indicatorColor: Colors.lightBlue,
            labelColor: Colors.lightBlue,
            unselectedLabelColor: Colors.white,
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  'All Coins',
                  style: TextStyle(
                      fontSize: screenHeight * 0.017,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2),
                ),
              ),
              Tab(
                child: Text(
                  'My Watchlist',
                  style: TextStyle(
                      fontSize: screenHeight * 0.017,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            allCoinsTab!,
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
      ),
    );
  }
}

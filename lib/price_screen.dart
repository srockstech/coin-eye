import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utilities/coin_card.dart';
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
        backgroundColor: Colors.yellow.shade600,
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
              color: Colors.black,
            ),
          )
        ],
        bottom: TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicatorColor: Colors.green.shade600,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'All Coins',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'My Watchlist',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'COIN NAME',
                            style: kFieldNameTextStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'PRICE',
                          textAlign: TextAlign.center,
                          style: kFieldNameTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: SizedBox(
                  height: 0,
                  child: Divider(
                    // height: ,
                    thickness: 1,
                  ),
                ),
              ),
            ],
          ),
          CoinCard(
            coinName: 'Bitcoin',
            coinCode: 'BTC',
            rate: null,
          ),
          CoinCard(
            coinName: 'Ethereum',
            coinCode: 'ETH',
            rate: null,
          ),
          CoinCard(
            coinName: 'Litecoin',
            coinCode: 'LTC',
            rate: null,
          ),
        ],
      ),
    );
  }
}

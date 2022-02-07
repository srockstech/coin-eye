import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../utilities/coin_card.dart';
import '../services/coin_data.dart';

class AllCoinsList extends StatefulWidget {
  final List<dynamic> coinsDataList;
  final String selectedCurrencyCode;
  AllCoinsList(this.coinsDataList, this.selectedCurrencyCode);

  @override
  _AllCoinsListState createState() => _AllCoinsListState();
}

class _AllCoinsListState extends State<AllCoinsList> {
  List<dynamic> coinsData;

  void updateCoinPrice(currentCoinData) {
    setState(() {
      coinsData = currentCoinData;
    });
  }

  List<Widget> coinCards() {
    Widget coinCard;
    List<Widget> coinCardsList = [];
    for (var coinData in coinsData) {
      var priceInString;
      var price = double.parse(coinData[0]['price']);
      if (price < 1) {
        priceInString = price.toStringAsFixed(6);
      } else {
        priceInString = price.toStringAsFixed(2);
      }
      coinCard = CoinCard(
        coinName: coinName[coinData[0]['symbol']],
        coinCode: coinData[0]['symbol'],
        rate: priceInString,
        selectedCurrencyCode: widget.selectedCurrencyCode,
        logoUrl: coinData[0]['logo_url'],
      );
      coinCardsList.add(coinCard);
    }
    return coinCardsList;
  }

  @override
  void initState() {
    super.initState();
    // print((widget.coinsDataList)[0]['rate']);
    updateCoinPrice(widget.coinsDataList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
        Column(
          children: coinCards(),
        ),
      ],
    );
  }
}

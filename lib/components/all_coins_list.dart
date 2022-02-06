import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../utilities/coin_card.dart';
import '../services/coin_data.dart';

class AllCoinsList extends StatefulWidget {
  final List<dynamic> coinsDataList;
  AllCoinsList(this.coinsDataList);

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
      coinCard = CoinCard(
        coinName: coinName[coinData['asset_id_base']],
        coinCode: coinData['asset_id_base'],
        rate: coinData['rate'].toStringAsFixed(3),
        selectedCurrencyCode: coinData['asset_id_quote'],
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

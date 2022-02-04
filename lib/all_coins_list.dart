import 'package:flutter/material.dart';
import 'utilities/constants.dart';
import 'utilities/coin_card.dart';

class AllCoinsList extends StatelessWidget {
  final String selectedCurrencyCode;
  AllCoinsList(this.selectedCurrencyCode);

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
        CoinCard(
          coinName: 'Bitcoin',
          coinCode: 'BTC',
          rate: 269578.77,
          selectedCurrencyCode: selectedCurrencyCode,
        ),
        CoinCard(
          coinName: 'Ethereum',
          coinCode: 'ETH',
          rate: 36363.77,
          selectedCurrencyCode: selectedCurrencyCode,
        ),
        CoinCard(
          coinName: 'Litecoin',
          coinCode: 'LTC',
          rate: 12244.77,
          selectedCurrencyCode: selectedCurrencyCode,
        ),
      ],
    );
  }
}

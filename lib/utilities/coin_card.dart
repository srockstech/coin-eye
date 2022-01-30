import 'package:flutter/material.dart';
import 'constants.dart';

class CoinCard extends StatelessWidget {
  final String coinName;
  final String coinCode;
  final double rate;

  CoinCard(
      {@required this.coinName, @required this.coinCode, @required this.rate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coinName,
                          style: kCoinNameTextStyle,
                        ),
                        Text(
                          coinCode,
                          style: kCoinCodeTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '$rate',
                    textAlign: TextAlign.center,
                    style: kRateTextStyle,
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
    );
  }
}

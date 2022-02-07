import 'package:flutter/material.dart';
import 'constants.dart';
import '../services/networking.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinCard extends StatelessWidget {
  final String coinName;
  final String coinCode;
  final String rate;
  final String selectedCurrencyCode;
  final String logoUrl;
  CoinCard({
    @required this.coinName,
    @required this.coinCode,
    @required this.rate,
    @required this.selectedCurrencyCode,
    @required this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  child: SvgPicture.network(
                    logoUrl,
                  ),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
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
                  child: Column(
                    children: [
                      Text(
                        '$rate',
                        textAlign: TextAlign.center,
                        style: kRateTextStyle,
                      ),
                      Text(
                        '$selectedCurrencyCode',
                        textAlign: TextAlign.center,
                        style: kCurrencyCodeTextStyle,
                      ),
                    ],
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import '../services/networking.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinCard extends StatefulWidget {
  final String coinName;
  final String coinCode;
  final String rate;
  final String percent24HChange;
  final String selectedCurrencyCode;
  final String logoUrl;
  Color eyeIconColor = Colors.grey[300];

  CoinCard({
    @required this.coinName,
    @required this.coinCode,
    @required this.rate,
    @required this.percent24HChange,
    @required this.selectedCurrencyCode,
    @required this.logoUrl,
  });

  @override
  _CoinCardState createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
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
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.network(
                    widget.logoUrl,
                  ),
                  height: 35,
                  width: 35,
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.coinName,
                          style: kCoinNameTextStyle,
                        ),
                        Text(
                          widget.coinCode,
                          style: kCoinCodeTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.rate,
                          style: kRateTextStyle,
                        ),
                        Text(
                          widget.selectedCurrencyCode,
                          textAlign: TextAlign.center,
                          style: kCurrencyCodeTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xAAE5FBF0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                    child: Text(
                      widget.percent24HChange,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF43BC7A),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.eyeIconColor = Colors.yellow.shade700;
                      });
                    },
                    child: Icon(
                      CupertinoIcons.eye,
                      // color: Colors.yellow.shade700,
                      // color: Color(0xFF2BFFF1),
                      color: widget.eyeIconColor,
                      size: 25,
                    ),
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

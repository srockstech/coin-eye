import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:coin_eye/services/coin_data.dart';
import 'package:coin_eye/components/all_coins_list.dart';

class LoadingSpinner extends StatefulWidget {
  final String selectedCurrency;
  LoadingSpinner({@required this.selectedCurrency});

  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner> {
  Widget allCoinsTab;
  void getCoinsCurrentData() async {
    List<dynamic> coinsDataList = [];
    for (var coinCode in coinName.keys) {
      var coinData =
          await CoinData(coinCode: coinCode, currency: widget.selectedCurrency)
              .getCoinData();
      coinsDataList.add(coinData);
    }
    setState(() {
      allCoinsTab = AllCoinsList(coinsDataList);
    });
  }

  @override
  void initState() {
    super.initState();
    print('init Called');
    allCoinsTab = Center(
      child: SpinKitRing(
        color: Colors.black,
        size: 30,
        lineWidth: 4,
      ),
    );
    Future.delayed(Duration.zero, () {
      getCoinsCurrentData();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build Called');
    return allCoinsTab;
  }
}

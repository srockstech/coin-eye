import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'networking.dart';

const Map<String, String> currenciesList = {
  'AUD': '\$',
  'BRL': 'R\$',
  'CAD': '\$',
  'CNY': '¥',
  'EUR': '€',
  'GBP': '£',
  'HKD': '\$',
  'IDR': 'Rp',
  'ILS': '₪',
  'INR': '₹',
  'JPY': '¥',
  'MXN': '\$',
  'NOK': 'kr',
  'NZD': '\$',
  'PLN': 'zł',
  'RON': 'lei',
  'RUB': '₽',
  'SEK': 'kr',
  'SGD': '\$',
  'USD': '\$',
  'ZAR': 'R'
};

const cmcMetaDataApiURL =
    'https://pro-api.coinmarketcap.com/v2/cryptocurrency/info';
const cmcApiKey = '15e33201-d615-4852-8a10-1523da86bc7e';

const cmcLatestListingsApiURL =
    'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

const noOfCoins = 300;

class CoinData {
  final String currency;
  Map<String, String> _coinsName = {
    // eg. 'BTC': 'Bitcoin',
  };

  Map<String, double> _coinsPrice = {
    // eg. 'BTC': '2990023.34213624',
  };

  Map<String, double> _coins24HChange = {
    // eg. 'BTC': '2.4',
  };

  CoinData({@required this.currency});

  Map<String, String> getCoinsName() {
    return _coinsName;
  }

  Map<String, double> getCoinsPrice() {
    return _coinsPrice;
  }

  Map<String, double> getCoins24Change() {
    return _coins24HChange;
  }

  void setCoinsPrice(newCoinsPrice) {
    _coinsPrice = newCoinsPrice;
  }

  Future<Map<String, double>> fetchCoinsPrices() async {
    Map<String, double> priceList = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$cmcLatestListingsApiURL?CMC_PRO_API_KEY=$cmcApiKey&convert=$currency&limit=$noOfCoins');
    var coinData = await networkHelper.getData();
    int i = 0;
    for (var coin in _coinsName.keys) {
      priceList[coin] = coinData['data'][i]['quote'][currency]['price'];
      i++;
    }
    return priceList;
  }

  Future<Map<String, double>> fetchCoins24HChange() async {
    Map<String, double> coins24HChangeList = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$cmcLatestListingsApiURL?CMC_PRO_API_KEY=$cmcApiKey&convert=$currency&limit=$noOfCoins');
    var coinData = await networkHelper.getData();
    int i = 0;
    for (var coin in _coinsName.keys) {
      coins24HChangeList[coin] = (coinData['data'][i]['quote'][currency]
              ['percent_change_24h'])
          .toDouble();
      i++;
    }

    return coins24HChangeList;
  }

  Future<Map<String, String>> fetchCoinsListings() async {
    Map<String, String> coins = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$cmcLatestListingsApiURL?CMC_PRO_API_KEY=$cmcApiKey&convert=$currency&limit=$noOfCoins');
    var coinData = await networkHelper.getData();
    for (int i = 0; i < 300; i++) {
      coins[coinData['data'][i]['symbol']] = coinData['data'][i]['name'];
    }
    return coins;
  }

  Future<dynamic> fetchCoinsMetaData() async {
    _coinsName = await fetchCoinsListings();
    _coinsPrice = await fetchCoinsPrices();
    _coins24HChange = await fetchCoins24HChange();
    String coinCodeList = '';
    for (var coinName in _coinsName.keys) {
      if (coinName == 'FCT,FCT2') {
        if (coinName == _coinsName.keys.last)
          coinCodeList += 'FCT';
        else {
          coinCodeList += 'FCT,';
        }
        continue;
      }
      if (coinName == _coinsName.keys.last) {
        coinCodeList += coinName;
      } else {
        coinCodeList += coinName;
        coinCodeList += ',';
      }
    }

    NetworkHelper networkHelper = NetworkHelper(
        '$cmcMetaDataApiURL?CMC_PRO_API_KEY=$cmcApiKey&symbol=$coinCodeList&aux=logo');
    var coinsData = await networkHelper.getData();

    return coinsData;
  }
}

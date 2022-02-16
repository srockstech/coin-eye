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

const noOfCoins = 20;

class CoinData {
  final String currency;
  Map<String, String> _coinsName = {
    // 'BTC': 'Bitcoin',
    // 'SOL': 'Solana',
    // 'YFI': 'yearn.finance',
    // 'ETH': 'Ethereum',
    // 'MKR': 'Maker',
    // 'BNB': 'Binance Coin',
    // 'BCH': 'Bitcoin Cash',
    // 'KSM': 'Kusama',
    // 'LTC': 'Litecoin',
    // 'QNT': 'Quant'
  };

  CoinData({@required this.currency});

  Map<String, String> getCoinsName() {
    return _coinsName;
  }

  Future<Map<String, String>> getAllCoinsListings() async {
    Map<String, String> coins = {};
    NetworkHelper networkHelper = NetworkHelper(
        '$cmcLatestListingsApiURL?CMC_PRO_API_KEY=$cmcApiKey&convert=$currency&limit=$noOfCoins');
    var coinData = await networkHelper.getData();
    for (int i = 0; i < 20; i++) {
      coins[coinData['data'][i]['symbol']] = coinData['data'][i]['name'];
    }
    return coins;
  }

  Future<List<dynamic>> getCoinsMetaData() async {
    _coinsName = await getAllCoinsListings();
    List<dynamic> coinsDataList = [];
    for (var coinCode in _coinsName.keys) {
      NetworkHelper networkHelper = NetworkHelper(
          '$cmcMetaDataApiURL?CMC_PRO_API_KEY=$cmcApiKey&symbol=$coinCode&aux=logo');
      var coinData = await networkHelper.getData();
      coinsDataList.add(coinData);
    }
    return coinsDataList;
  }
}

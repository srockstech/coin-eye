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

const Map<String, String> coinName = {
  'BTC': 'Bitcoin',
  'SOL': 'Solana',
  'YFI': 'yearn.finance',
  'ETH': 'Ethereum',
  'MKR': 'Maker',
  'BNB': 'Binance Coin',
  'BCH': 'Bitcoin Cash',
  'LTC': 'Litecoin',
  'XRP': 'Ripple',
};

const coinApiURL = 'https://api.nomics.com/v1/currencies/ticker';
const coinApiKey = '2789cade360e8e97437724594cd2c98a49839328';

class CoinData {
  final String coinCode;
  final String currency;

  CoinData({@required this.coinCode, @required this.currency});

  Future<dynamic> getCoinData() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$coinApiURL?key=$coinApiKey&ids=$coinCode&convert=$currency');
    var coinData = await networkHelper.getData();
    return coinData;
  }
}

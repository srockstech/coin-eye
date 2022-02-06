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
  'ETH': 'Ethereum',
  'LTC': 'Litecoin',
};

const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate';
const coinApiKey = '2A44A8C6-035F-4861-BD9A-8BF5AA1BA23C';

class CoinData {
  final String coinCode;
  final String currency;

  CoinData({@required this.coinCode, @required this.currency});

  Future<dynamic> getCoinData() async {
    NetworkHelper networkHelper =
        NetworkHelper('$coinApiURL/$coinCode/$currency?apikey=$coinApiKey');
    var coinData = await networkHelper.getData();
    return coinData;
  }
}

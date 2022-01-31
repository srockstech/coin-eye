import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyIcon {
  IconData getIcon(String value) {
    if (value == '€') {
      return CupertinoIcons.money_euro;
    }
    if (value == '£') {
      return CupertinoIcons.money_pound;
    } else {
      return CupertinoIcons.money_dollar;
    }
  }
}

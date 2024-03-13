import 'dart:io' show Platform, sleep;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'rate_widget.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = currenciesList[0];
  bool isWaiting = true;
  Map<String, String> coinData = {};


  @override
  void initState() {
    super.initState();
    newCurrencySelected(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildRows(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: buildCurrencySelector(),
          ),
        ],
      ),
    );
  }

  buildRows() {
    return cryptoList
        .map((e) => RateWidget(e, selectedValue, rateValue()))
        .toList();
  }

  String rateValue() {
    if (isWaiting) {
      return "?";
    } else {
      var result = coinData[selectedValue];
      return result == null ? "?" : result;
    }
  }

  CupertinoPicker buildCupertinoPicker() {
    List<Text> widgets = buildItemWidgets();
    return CupertinoPicker(
      children: widgets,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          String? selectedData = widgets[selectedIndex].data;
          if (selectedData != null) {
            newCurrencySelected(selectedData);
          }
        });
      },
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: selectedValue,
      items: buildItems(),
      onChanged: (newValue) {
        setState(() {
          if (newValue != null) {
            newCurrencySelected(newValue);
          }
        });
      },
    );
  }

  List<DropdownMenuItem<String>> buildItems() {
    return buildItemWidgets()
        .map((e) => DropdownMenuItem(
              child: e,
              value: e.data,
            ))
        .toList();
  }

  List<Text> buildItemWidgets() {
    return currenciesList
        .map(
          (e) => Text(e),
        )
        .toList();
  }

  buildCurrencySelector() {
    if (Platform.isIOS) {
      return buildCupertinoPicker();
    }
    return buildDropdownButton();
  }

  void newCurrencySelected(String currency) async {
    selectedValue = currency;
    isWaiting = true;
    var data = await request(currency);
    setState(() {
      coinData = data;
      isWaiting = false;
    });
  }
}

Future request(String currency) async {
  //sleep(Duration(seconds: 2));
  if (currency == "USD") {
    return {"BTC": "11.11", "ETH": "22.11", "LTC": "33.11"};
  }
  if (currency == "GBP") {
    return {"BTC": "11.22", "ETH": "22.22", "LTC": "33.22"};
  }
  return {"BTC": "11.33", "ETH": "22.33", "LTC": "33.33"};
}

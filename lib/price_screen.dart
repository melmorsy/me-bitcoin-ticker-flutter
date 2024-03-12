import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedValue = currenciesList[0];


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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? $selectedValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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

  CupertinoPicker buildCupertinoPicker() {
    List<Text> widgets = buildItemWidgets();
    return CupertinoPicker(
      children: widgets,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          String? selectedData = widgets[selectedIndex].data;
          if(selectedData != null) {
            selectedValue = selectedData;
          }
        });

      },
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
            value: selectedValue,
            items: buildItems(),
            onChanged: (newValue){
              setState(() {
                if(newValue != null) {
                  selectedValue = newValue;
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
        .map((e) => Text(e),)
        .toList();
  }

  buildCurrencySelector() {
    if(Platform.isIOS) {
      return buildCupertinoPicker();
    }
    return buildDropdownButton();
  }
}

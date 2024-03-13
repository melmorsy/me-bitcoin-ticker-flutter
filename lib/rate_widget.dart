import 'dart:io';

import 'package:flutter/material.dart';

class RateWidget extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;
  final String rateValue;

  RateWidget(this.fromCurrency, this.toCurrency, this.rateValue);


  @override
  Widget build(BuildContext context) {
    /*request(widget.fromCurrency, widget.toCurrency).then((value){
      setState(() {
        if(value != null) {
          rateValue = value.toStringAsFixed(2);
        }
      });
    });*/
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${fromCurrency} = $rateValue ${toCurrency}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/*class _RateWidgetState extends State<RateWidget> {

  String rateValue = "<calculating>";


  @override
  void initState() {
    super.initState();
    request(widget.fromCurrency, widget.toCurrency).then((value){
      setState(() {
        if(value != null) {
          rateValue = value.toStringAsFixed(2);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${widget.fromCurrency} = $rateValue ${widget.toCurrency}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}*/



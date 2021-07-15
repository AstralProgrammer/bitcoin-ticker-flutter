import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'modules/crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency;
  CoinData coinData = CoinData();
  Map<String, String> rateList = {};
  bool isWaiting = false;

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropdownList = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownList.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownList,
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value;
        });
        getData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> dropdownList = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      dropdownList.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        var selectedCurrency = currenciesList[selectedIndex];
        setState(() {
          selectedCurrency = selectedCurrency;
        });
        getData();
      },
      children: dropdownList,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    isWaiting = true;
    try {
      var data = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;

      setState(() {
        rateList = data;
      });
    } catch (e) {
      print(e);
    }
  }

  List<CryptoCard> cryptoCardList () {
    List<CryptoCard> list = [];
    for (String crypto in cryptoList) {
      var item = CryptoCard(
        currency: crypto,
        //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
        value: isWaiting ? '?' : rateList[crypto],
        selected: selectedCurrency,
      );
      list.add(item);
    }
    return list;
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
            children: cryptoCardList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

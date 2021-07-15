import 'dart:convert';
import 'package:http/http.dart';
import 'http_helper.dart';
import 'dart:math';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String kExchangeRateUrl = 'rest.coinapi.io';
const String kApiKey = '47D42E09-7E12-406A-BC97-6F7721CD1068';
HttpHelper http = HttpHelper();

class CoinData {
  Future<dynamic> getCoinData(String currency) async {

    Map<String,String> rates = {};

    for (String crypto in cryptoList) {
      currency = currency.toUpperCase();
      String type = crypto.toUpperCase();
      Response response = await http.get(
        domain: kExchangeRateUrl,
        path: '/v1/exchangerate/$type/$currency',
        params: {
          'apiKey': kApiKey,
        },
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        double currentRate = json['rate'];
        rates[crypto] = currentRate.toStringAsFixed(2);
      } else {
        throw 'Unable to fetch data';
      }
    }

    return rates;
  }
}

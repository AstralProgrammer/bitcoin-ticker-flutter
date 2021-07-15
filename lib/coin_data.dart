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
  Future<double> getCoinData(String currency, String type) async {
    type = type.toUpperCase();
    currency = currency.toUpperCase();
    Response response = await http.get(
      domain: kExchangeRateUrl,
      path: '/v1/exchangerate/$type/$currency',
      params: {
        'apiKey': kApiKey,
      },
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json['rate'];
    }

    return 0;
  }
}

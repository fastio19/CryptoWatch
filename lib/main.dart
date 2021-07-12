// @dart=2.9
import 'dart:io';
import 'package:http/http.dart';
import 'package:meta/dart2js.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() async{
  final List currencies=await getCurrencies();
  print(currencies);
  runApp(MyApp(currencies));
}
class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new HomePage(_currencies),
    );
  }
}
Future<List> getCurrencies() async{
  String url="https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  String cryptoUrl="https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=698174fd-dfda-4345-8cae-c1793171b8b8";
  http.Response response=await http.get(Uri.parse(url));
  if(response.statusCode==200){
    return jsonDecode(response.body);
  }
  else{
    throw Exception('Failed to load url');
  }
}

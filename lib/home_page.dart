import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget{
  List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState()=> new _HomePageState();
}
class _HomePageState extends State<HomePage>{
  final List<MaterialColor> _colors=[Colors.blue,Colors.indigo,Colors.red];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto App"),
      ),
      body: _cryptoWidget(),
    );
  }
  Widget _cryptoWidget(){
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context,int index){
                final Map currency=widget.currencies[index];
                final MaterialColor color=_colors[index%_colors.length];
                return _getListItemUi(currency,color);

              },
            ),
          ),
        ],
      )
    );
  }
  ListTile _getListItemUi(Map currency,MaterialColor color){
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(
          currency['name'][0],
        ),
      ),
      title: new Text(
        currency['name'],
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(
          currency['current_price'].toString(),currency['price_change_percentage_24h'].toString()
      ),
      isThreeLine: true,
      
    );
  }
  Widget _getSubtitleText(String priceUSD,String percentageChange){
      TextSpan priceTextWidget=new TextSpan(text: "\$$priceUSD\n",
        style: new TextStyle(color: Colors.black)
      );
      String percentagechangeText="24 hour: "+percentageChange+"%";
      TextSpan percentageChangeTextWidget;
      if(double.parse(percentageChange)>0){
        percentageChangeTextWidget=new TextSpan(
            text: percentagechangeText,
            style: new TextStyle(color: Colors.green));
      }
      else{
        percentageChangeTextWidget=new TextSpan(
            text: percentagechangeText,
            style: new TextStyle(color: Colors.red));
      }
      return new RichText(
          text: new TextSpan(
          children: [priceTextWidget,percentageChangeTextWidget]
      )
      );
  }
}
import 'package:flutter/material.dart';
import 'Const_Coin.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'ApiClass.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectCurencyone = "BTC";
  String? selectCurencytwo = "BTC";
  double result = 0.0;

  ApiClass api = ApiClass();

  getDropdownMenuButton(String? select, int i) {
    List<DropdownMenuItem<String>> listItem = [];
    for (String stringitem in coin) {
      var item = DropdownMenuItem(
        child: Row(
          children: [Text(stringitem), Icon(Icons.api)],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        value: stringitem,
      );
      listItem.add(item);
    }
    return DropdownButton<String>(
      value: select,
      items: listItem,
      onChanged: (value) {
        setState(() {
          select = value;
          print(select);
          if (i == 1) {
            selectCurencyone = select;
          } else {
            selectCurencytwo = select;
          }
        });
      },
    );
  }

  CupertinoPicker iosCupertinoPicker() {
    List<Widget> listItemIos = [];
    for (String stringitem in coin) {
      listItemIos.add(Text(stringitem));
    }
    return CupertinoPicker(
      backgroundColor: Colors.yellow,
      children: listItemIos,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "1 $selectCurencyone = ${(result == 0.0) ? "?" : result.toStringAsFixed(2)} $selectCurencytwo",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.yellow,),
                      onPressed: () async {
                        result = await api.getResultChange(
                            oneParameter: selectCurencyone ?? "ETH",
                            twoParameter: selectCurencytwo ?? "ETH");
                        setState(() {});
                      },
                      child: Text("click",style: TextStyle(color: Colors.black87,fontSize: 25),)),
              ],
            ),
                )),
            Container(
              color: Colors.yellow,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: Platform.isIOS
                          ? iosCupertinoPicker()
                          : getDropdownMenuButton(selectCurencyone, 1)),
                  Icon(Icons.arrow_forward_sharp),
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: Platform.isIOS
                          ? iosCupertinoPicker()
                          : getDropdownMenuButton(selectCurencytwo, 2)),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

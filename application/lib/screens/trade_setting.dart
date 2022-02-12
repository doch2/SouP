import 'package:flutter/material.dart';

class TradeSetting extends StatelessWidget {
  TradeSetting({Key? key}) : super(key: key);

  late double _height, _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text("Trade Setting")
          ],
        )
      ),
    );
  }
}
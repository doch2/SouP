import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/stock_controller.dart';
import 'package:soup/widget/bottomdesign.dart';

class StockPage extends StatelessWidget {
  StockPage({Key? key}) : super(key: key);

  late double _height, _width;

  StockController controller = Get.find<StockController>();

  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          BottomDesign(width: _width, height: _height),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              controller.obx((state) {
                final res = controller.info.value.res;
                final body = json.decode(res.body);

                return Text(
                    "${body['quoteResponse']['result'][0]['longName']} : ${controller.price.value.currentPrice}원");
              }, onLoading: CircularProgressIndicator()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("구매"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("판매"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}

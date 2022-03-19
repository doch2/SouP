import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/stock_controller.dart';
import 'package:soup/themes/text_theme.dart';
import 'package:soup/widget/bottomdesign.dart';
import 'package:soup/widget/soupbutton.dart';

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

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.price.value.currentPrice}원",
                      style: homeUserName,
                    ),
                    Text(
                      "${body['quoteResponse']['result'][0]['longName']}",
                      style: homeHello,
                    ),
                  ],
                );
              }, onLoading: CircularProgressIndicator()),
              SizedBox(
                height: 36,
              ),
              SoupButton(
                width: _width,
                height: _height,
                text: "주식 구매하기",
              )
            ]),
          ),
        ],
      ),
    );
  }
}

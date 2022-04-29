import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/stock_controller.dart';
import 'package:soup/models/stock.dart';
import 'package:soup/models/xingapi_request.dart';
import 'package:soup/services/account.dart';
import 'package:soup/services/xingapi.dart';
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
                controller.stockInform.value =
                    StockInformation.fromJson(body: body);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => controller.isRealtime.value
                        ? const Card(
                            color: Colors.green,
                            child: Text(
                              "실시간",
                              style: loginBoxTitle,
                            ),
                          )
                        : const Card()),
                    Text(
                      "${controller.stockInform.value.stockName}",
                      style: homeHello,
                    ),
                    Obx(() => Text(
                          "${controller.stockInform.value.marketPrice} KRW",
                          style: homeUserName,
                        )),
                    Text(
                      controller.getCurrentState(),
                      style: loginSubTitle,
                    ),
                  ],
                );
              }, onLoading: const CircularProgressIndicator()),
              const SizedBox(
                height: 36,
              ),
              SoupButton(
                width: _width,
                height: _height,
                text: "주식 구매하기",
                onTap: () async {
                  print("구매");
                  await XingAPI(
                          accountStr: Account.account,
                          password: Account.password)
                      .orderStock(
                          controller.ticker.value,
                          1,
                          controller.stockInform.value.bid!.toInt(),
                          StockOrderType.buy,
                          StockOrderQuoteType.marketOrder);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SoupButton(
                width: _width,
                height: _height,
                text: "실시간 정보 가져오기",
                onTap: () => controller.getRealtimeStock(),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("나가기"),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.logout)
                  ],
                )),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

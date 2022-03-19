import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:soup/controllers/user_controller.dart';
import 'package:soup/models/stock.dart';
import 'package:soup/themes/color_theme.dart';
import 'package:soup/themes/text_theme.dart';
import 'package:soup/widget/bottomdesign.dart';
import 'package:soup/widget/stocklist.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  late double _height, _width;
  late UserController userController;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    userController = Get.find<UserController>();

    return Scaffold(
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(color: blueOne),
            width: _width,
            height: _height,
          ),
          BottomDesign(width: _width, height: _height),
          Positioned(
            top: _height * 0.125,
            left: _width * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "안녕하세요!",
                  style: homeHello,
                ),
                Obx(() => Text(
                      "${userController.user.name}님",
                      style: homeUserName,
                    ))
              ],
            ),
          ),
          Positioned(
            top: _height * 0.225,
            left: _width * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "현재 서버 상태",
                  style: homeHello,
                ),
                Text(
                  "정상",
                  style: homeHello,
                )
              ],
            ),
          ),
          Positioned(
            top: _height * 0.325,
            left: _width * 0.1,
            child: StockList(
              height: _height,
              width: _width,
              list: [
                StockModel(stockId: "005930", name: "삼성전자"),
                StockModel(stockId: "035720", name: "카카오"),
                StockModel(stockId: "247540", name: "에코프로비엠"),
                StockModel(stockId: "005380", name: "현대차"),
                StockModel(stockId: "089980", name: "상아프론테크"),
              ],
              recommanded: true,
            ),
          )
        ],
      )),
    );
  }
}
